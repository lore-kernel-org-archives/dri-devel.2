Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B68CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EF410EBBD;
	Thu, 15 Oct 2026 13:25:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9926910EBBD
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:25:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jZJg2966434
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kXzuvyD7vEPKPmhhGzoxroGZUMQEvbNNj+wxq/Ak3M8=; b=V6ffvFYrIJOQL3pg
 a4UkYBPHULoo2vY914IfBEcZtedRpkNIZHo9Gx6V7PPtFdReNYmMz8UJvZBqkTAQ
 oaHnPXO4q6bfFlS6HhKe7f0I6u0/m+aoPvsni3FXrzFspIIQlPkWBjH3tegB+2yJ
 B6U1Ft1E3RkWDNy7JYtQ0zvh2NwtBbKysGWIdtLcV2fH3f5DnV4TbxwSsO6k7dzA
 Usm8Q46C2iM55r93NNf7b2VnKGt441w5JzijLxbon3n1LEIAuDpiF9c+PGimhITe
 3irRwyxMn/j43KlC9Y8vvlPQ3nO2fHCGaM542bDzGg08oRMSpCe2rAkQGXDrVUil
 4YpKZQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wv7xq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:25:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso6355947a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792070701; x=1792675501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kXzuvyD7vEPKPmhhGzoxroGZUMQEvbNNj+wxq/Ak3M8=;
 b=aSDj3AQx8z+F9MH/jMmzQ7c5eUI0cLS+ky2/xXJaK0qOg2vqJJ+gW+U4BFvDVF/CQV
 UC44ZyDPsFp73HLIZnKNgAlAEHuI010ju3Nps7ChqZ2nb+VfVzrA9hFC6x+wdAjatrZg
 rDbiJwYo+bVoyW2UQePRnUxClfu1pBfc77U5vpiE5WCoxuwMWS0N5o4xVPbmTOaej8M0
 Dm0+Krf/sQ8NMPpHoQXNVJC0/dbJhLcCwVet5jcDCCBnFaLEfxSrgoYLlbCwJ/Fh2GYQ
 +N456mGQvWxgzk/AGuQDHsPt+PYA5ccn9qsSKWeB8xpFJsH6nedLN2MuimR+afm/PQWB
 B4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792070701; x=1792675501;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kXzuvyD7vEPKPmhhGzoxroGZUMQEvbNNj+wxq/Ak3M8=;
 b=jK5qt6gxd36zhL9wIu3OasxpjrnVVd5A4GOiIoM6RW6yyEwOOmFHhzZfBPTlsO6x3c
 xq4csM3ii+8z5ukrF04HrRL8zER6IcR4hE2AtlUIi4QmXO/HQ19TlOh8rZwTrGvVO719
 RSNKhEntrAG7VaG93MFrRUIDlv/znGfTlOwGpwV7LKimkKuRNgRpbe1dxugTK0yM2oTK
 Tf3QkiazTGaba/dGoo4UTF1tefl6OstTo7IK13FY3MRwhwsV2tHgq3Wp8NR90mFWwbax
 QiJXhS+X7GLbkzvf7FrPeGVT+5HhwaxrQDuJIZhqaYkVNdqY+LsgDk8TaGAh2gBOgeI0
 z++w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdBBNZ9mZ4coZta3jQjEAddt9HXze/GMINVtsS9PrSOtBTpKl8HxEvdmOX/SY+rOkvI7npxX90Cbw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKmHheyUVsKXuRjDDWKJgFtWveyoHCQhedZY/j7KNz9hmjVkwRy
 miy/YQOgzHLG+W3hsKdJilTa3JtX0AN0kcgQrYCcfiMcEAZyJK1p/VdVfhnAhE/2siXNPhrBcal
 PyPjulKLpCWha+leehWLf5fr3DUNUrcOsJ+410g1OfstqW9ThIegD+v66TesEMBTfpW4mI9P62u
 8/Yog=
X-Gm-Gg: AYBFou1UtG4mirVsh0oCCSA55gE5Ge2gfExU26wBeCtQlkD5AJTPakKMZuwY7dEBI0X
 L91ZGJ4Sb2aDoU4PtkLapojh6BTiX0inqBm7RcX5K0s/ZmQfDG3COhkCCynOhKwMgrjGImvq51Q
 8EzhUkpZ/DErjdpxsfButd3DWoZzSyQJy3w8L8qV4YsIdt8QEySPeD6c9iyBhA2qvoLViNLTHwQ
 AVLKsh2RyaJFJOoDgZli/MZqdULwuf3X5wSpnhO48QB4FrjvpO6qxbxtmUv+WIHqHgRjPrCHVml
 u9oVJM4QTGvG/4XYR1k/ViAAToEp4Z3aE/3VJ1u2V4jBh8oZTSCifLErGYXEfD7BN1RWGFnrR61
 R0UYlgwICSeqzH7kkN5EIfFr9vb4=
X-Received: by 2002:a17:90b:2b48:b0:3a8:1320:38b5 with SMTP id
 98e67ed59e1d1-3ab3a747d7amr15737745a91.30.1792070700340; 
 Thu, 15 Oct 2026 06:25:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2b48:b0:3a8:1320:38b5 with SMTP id
 98e67ed59e1d1-3ab3a747d7amr15737710a91.30.1792070699787; 
 Thu, 15 Oct 2026 06:24:59 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9437aa5fsm4592400a91.3.2026.10.15.06.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 06:24:59 -0700 (PDT)
Message-ID: <ab5ebfa2-9687-48ba-8403-186e517126d2@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 21:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
 <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX0WdxwJyNqnmy
 15+3TVAGhAmhriJv93dzpLa5fyybin9kOrVQi1gpIvGgn+gl0Kp0lOOYR/P4vbN1bu7dZNk2dAU
 Y2lKVBCF7ruH5udlLtOduS06K/Ya1c8=
X-Proofpoint-ORIG-GUID: MdwvO64vMP6EySSITQVg9T09fTOoGuoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX4n+e+yfPbNla
 r6cJv1Nch+syKPEZKYRCrFSaRUBVnZS4sH4+4+XLFUkyeCRLRPCXpFnxcjdi5H5s9TcBaUMhyCS
 K8AAuaZuLB9bLTMXuD5mfB6r6odfVXWeWxYLvCOo+h/qagjbt2cmLyCkkBgXVBt7/xZ1COPFOxT
 5kARHns8NImiJ98B6w7neMje7ut4+KN1/6Mzn7wPAazCLzsgFUh/oIVybMtuZPq5KoGspVwaWgQ
 ttirJdERkCQhtg0Hcatxip9yTFIcvcbx4xodzZPcsL5ghqsHV93Ua2PckB02Q3aOBNp4+VpViUs
 FO6RsRyhoIuyl0mI9Spvsl0TEk50gHZ+YDVq6YCLBv91pSMBHbh4Hkvffz3r7KWHHqmYqRDKskq
 Y9zTfsvo+qAcVu+zcZXZ5RylXMKDr+bdd8I6F+YuTUnXBtHWY/OsLWDn5RDyaCIsHjU+Awo1xc6
 vUSSRh5LNjG1Nmumb2Q==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0d42d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pWGhcB3pyskuJKc3Q2AA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MdwvO64vMP6EySSITQVg9T09fTOoGuoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 10/1/2026 6:52 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 29, 2026 at 12:25:37PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
>> support for calculating the rate governor, slot allocation, and slot
>> reservation in the DP controller.
>>
>> Each MST stream can reserve its slots by calling
>> msm_dp_display_set_stream_info() from its bridge callbacks.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
>>   drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
>>   drivers/gpu/drm/msm/dp/dp_display.h |   2 +
>>   4 files changed, 206 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 929e0f94f8dd..02732bd4efa1 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -83,6 +83,7 @@
>>   #define MR_LINK_PRBS7 0x100
>>   #define MR_LINK_CUSTOM80 0x200
>>   #define MR_LINK_TRAINING4  0x40
>> +#define DP_MAX_TIME_SLOTS 64
>>   
>>   enum {
>>   	DP_TRAINING_NONE,
>> @@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
>>   	u8 tu_size_minus1;
>>   };
>>   
>> +struct msm_dp_mst_ch_slot_info {
>> +	u32 start_slot;
>> +	u32 tot_slots;
>> +	u32 pbn;
>> +};
> 
> How other drivers handle slot programming? Is it something to be shared
> between the drivers? If so, maybe it would be better to update MST
> helpers. Or, asking differently, why do we store it this way? I don't
start_slot, tot_slots, and pbn come from the MST atomic state. The MSM 
DP hardware uses start_slot and tot_slots to program the per-stream 
timeslot registers, while pbn is used to calculate the rate governor. 
Therefore, mst_ch_info[] is a cached copy added to make these values 
easily accessible to dp_ctrl.c.

Source hardware programming differs across vendors. Intel does not 
explicitly program per-stream absolute start-slot or slot-mask registers 
like QCOM does. Nouveau submits each head's allocation through its 
NVIF/VCPI interface, while AMD converts the complete allocation table 
into SAT entries and programs them into the source hardware. Therefore, 
DRM MST helpers can handle the common payload allocation and 
slot-shifting logic, but source hardware programming remains 
driver-specific.

Without mst_ch_info[], we would need to construct a temporary complete 
allocation table from the MST atomic state during stream enable/disable 
and pass it through dp_display.c to dp_ctrl.c. Specifically, this would 
require extending msm_dp_display_enable_helper(), 
msm_dp_display_disable_helper(), and msm_dp_ctrl_on_stream(). 
msm_dp_ctrl_mst_timeslot_setup() would then use this table to program 
the timeslot registers for all streams, while the current stream's pbn 
would be passed to the rate governor calculation.

> see where msm_dp_display_set_stream_info() will be called from, but
Sorry,  you are right. The call sites are introduced in a later patch. I 
will move this helper to the patch where it is first used.> isn't it a 
part of the calculated state? if so, all the slot allocation
> should be stored in the state structures rather than storing them
> directly in the private structure.
> 
>> +
>>   struct msm_dp_ctrl_private {
>>   	struct msm_dp_ctrl msm_dp_ctrl;
>>   	struct drm_device *drm_dev;
>> @@ -153,6 +160,8 @@ struct msm_dp_ctrl_private {
>>   	bool link_clks_on;
>>   	bool stream_clks_on[DP_STREAM_MAX];
>>   	bool mst_active;
>> +
>> +	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
>>   };
>>   
>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> 

