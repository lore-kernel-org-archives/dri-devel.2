Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57448CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D2E10FBAE;
	Wed, 14 Oct 2026 07:44:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69FC10FB9C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:44:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E5wrtP3951474
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qCCRSrNdX0Wl0cdwWasVKcxRpYvsw3s7ZcCpfOqb6w8=; b=nlSBL68YcU5o146Z
 z+K86ZUokgnNMPspK9D/WyhvvaCsFcAAwqxV24VJ1LDn0qXvvBcbDjmKhqLlZLhp
 bQZWnYUOvyZ/9SfJD10b1sKo/9CfoIq7Itkq997/dwpZ/jXF9wWnr+r4Vh6Ug4VW
 awDkU4LTEWJcc+z+TD0hdcCLbpyY1WHjxkPf6Vi9EqgaKfbhK9JCMB16sxdddXBO
 dOy7/aAmohUgtZFYjNhi+rDbQJf6jXZsa/WmySvdDWlMzSbIIRYt7aSYJdYSXYoA
 nIl0UdK11/YLtEOd7Wr/eWIsb8WXo70lgunu/27wbFPaB28nmzrx44/XLWeDRhoc
 GuUaWQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p0dgg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:44:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d001671a54so56399555ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791963857; x=1792568657;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qCCRSrNdX0Wl0cdwWasVKcxRpYvsw3s7ZcCpfOqb6w8=;
 b=BKGyACVycYlVClv5znyAVROFtIKg3RMLSW/uX1ve9uXrbqICIx7Q8GFRnHE66BE+vl
 evt/R/W/bUm7ma+LMf6MX+q27E1NvydKXk6guWm5akuvP0UlX5lIWlmbKSOrJWPRWZjM
 QBDSMbghCrQZ9BZCIE9yS/u3kVcNxDhv7hdtinT2a6zV6YfZ3dUKFgbl3pu1vqwzJRua
 2YFsS70cLIMIgg/lQr1e1qlHKdp7F84thOmfKFTQ+IJJEMYFfQgWNA1kD48p7HH8NwSJ
 OHxOTpWBqeqMkxU+PiRyncshcJTwcsu+147Rzx7zAiHwLyNYgAVP3Yf4ZPREJrUYAyRF
 uWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791963857; x=1792568657;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCCRSrNdX0Wl0cdwWasVKcxRpYvsw3s7ZcCpfOqb6w8=;
 b=RhEzfGOb9/PG3+B4DbrlwWJgYXTJ9jzOKp3dJ/CAcZ+Ww5dWWhaYaCHHiVQEc/yaMb
 GkdrKHVVoENNKksVJ7H/m3FMeGLH4V39njWjOXVLPJQOqulI2pj2e23aucnUlYBg2vFJ
 H8Z6Ps1Vl1EziQwuOLZ3iHFjdp167X5F8m1tciOQD+EjPwNgD1UolwdstR+8yRhjWPnD
 wPBN/xZ+Np087mOROPoPz6N6+oFtITpdQIHeIZByMarf2ZzgVoVRoWjXy4HLLQHRb2wA
 QwBmRu6v3w8sSg7cY/cfgRck3YIn4iZHTQajs03fX3NKzqZsGNmTtFk6MGCLvO/yxsz/
 MEjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiHlc/bXi63wjw9WEZQMdnGSDsX5Mqrgfqs4CHOUhNNpJRjemS2hJ0rVSqieMupjL/bqx1sRx5Y1M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLm7LxX1T5TRkzdDjigUJBH/L5YBc3KOmNx2Hb2yqglzSdFD2Za
 jj2fvRuuAH88f63Nqt09/K6e5HNNhjzUk9aIfnUFmRsyndhONKLd5T0oXwk6oCcTMHRKAyqDi92
 drlLbGnMJkhErHfJW/ktzOn+unttQPgFFTK9SOnhZHUKXRkmk2L6hPZ8la9P4iB3EQugFSGg=
X-Gm-Gg: AYBFou3y96huiLuZKB2zRNrcjHvmbpkaiWjmpc6tK3Fh1O2d7uSaWnNAlh6cMtcd/Qq
 qmWd6Jv/0f/YXtGQmyK08rRoTDVlz0/6AFStnxME32nml4kH7Rgohz3YDMRttlDoF3nrb1LLXPA
 tbOBQa8A6xfyR9B/Vx+MI5uupci3faF98alR3kl6HBwxgbH+Ms7RdGsDlpkAGkJMNNlDpu0XdlO
 6WAR1b0/pSSH5HS1XpV6oefMrhUJLqUeD+MRLupE/yoUFGgTMjqzwWTdE5Y6ppKm7OMsfEeUwe/
 2Qt02XXh821gl/bknK59reeUK4VtTaCLSO/XNE0MtFvh3SegKKZCGMek2J5FY+PymBVUMp9Ablo
 Xq+KoY8PkrE9II2MmNdSmc+FHLbTGQQ==
X-Received: by 2002:a17:903:41d0:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2e8429a9fb0mr134274785ad.10.1791963857431; 
 Wed, 14 Oct 2026 00:44:17 -0700 (PDT)
X-Received: by 2002:a17:903:41d0:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2e8429a9fb0mr134274455ad.10.1791963856917; 
 Wed, 14 Oct 2026 00:44:16 -0700 (PDT)
Received: from [10.218.9.97] ([202.46.22.19]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8dc4sm64418425ad.59.2026.10.14.00.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:44:16 -0700 (PDT)
Message-ID: <48de9560-76b8-47aa-a87d-361c4e784a40@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:14:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
 <ytqzmngqzb2ear5ovqexrzcw63t7plac7hvsbh3ce32krt4mfd@e3yyzs6y5anq>
 <926167d5-e912-42b5-a040-be2bf220adbc@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <926167d5-e912-42b5-a040-be2bf220adbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfXwF18/7LcSrfC
 nk0+wBSnezlkgNsjaTIONaJuCU0bQin9B1UKloI4v8Q6hwzm3qw7xhM/gY4s/2mVr9DbuvjeMTm
 s9xDGfTLPVoAqilWf/+dTBhV9zU7Gmw=
X-Proofpoint-ORIG-GUID: 805EnUOr9r_1Ltak7qRo0Ai87KECQVFZ
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acf32d2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4yO6XKe0Cte-09FKxggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMCBTYWx0ZWRfXyB+q7UGRPvmj
 q28NRjsbARXi9Ex8IEsPRTCJ64ks+R1HoQKDMG0Qr7P7EDc5Gqx7GqNPS+hh3iejDHq3xHxwnpU
 OONf3t74VqngC8tRGj//QH3VPGNMIKY5fa/uE4Dpa+0/ZQoqM30H1b05HBuNNM74p/n71Y8Emp3
 I/PNBWtC9Ztyc6Vu2HPsoG8zVlVUz3Bi+94AolUmb/N7khvIC25othSBW48ZsJmuwN8yZUv5UA+
 I1PssKdpNONr01WV6pKpF5sG4PXIol76S7Qygiv95nowy0qDeD1UTU3XEX9DL46vfWkJjJHP0gx
 WWx0rju/H+sUjMcouaZcWKwYK59ilvNamZcp6lN+wmn3XrkCEOs3iqi4trYGgFE+05vgN+SR/Ts
 3WXMiL009/MZ2Zv3vwrcZ9miP7n5rKZ7SOQMbWx6+kf396WbRhytCvOWtlJ49l+oCSk5zUa1bDd
 5/hTAHc+BbNnND8BMNQ==
X-Proofpoint-GUID: 805EnUOr9r_1Ltak7qRo0Ai87KECQVFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140030
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

Hi Balaji,

On 10/12/2026 11:47 AM, Balaji Kalkonda wrote:
> 
> On 09-10-2026 02:04 pm, Dmitry Baryshkov wrote:
>> On Mon, Oct 05, 2026 at 12:54:29PM +0530, Balaji Kalkonda wrote:
>>> MTP does not have audio jack connected and relies on USB mux (WCD9395).
>>> Add necessary nodes for proper audio headset support along with USB
>>> Type-C accessory mode and orientation.
>>>
>>> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 51 ++++++++++++++++++++++++++++++
>>>   1 file changed, 51 insertions(+)
>>>
>>> @@ -916,6 +926,42 @@ &gpu_zap_shader {
>>>   	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
>>>   };
>>>   
>>> +&i2c3 {
>> No clock-frequency?
>>
>>> +	status = "okay";
>>> +
>>> +	wcd_usbss: typec-mux@e {
> 
> Hi Dmitry,
> 
> The default I2C bus frequency for i2c3 is 100 kHz as configured by the controller driver. That is sufficient for the WCD9395 USB Type‑C mux use case, so an explicit clock-frequency property is not needed here.
> 
> Thanks and regards,
> 

Still the required frequency can be specified for your explicit need. Do 
not rely on default though it will serve your purpose.


> Balaji
> 
> 

