Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A46606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WYSudKPo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eVa7nMWY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6480710E330;
	Mon,  2 Nov 2026 09:40:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EBA10E5BD
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:40:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29APxu3086563
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 09:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0RisWK7U/ImCk7w0ULia5Tu4LqGc3vPjywy19ERXZsQ=; b=WYSudKPotsYPLwNp
 JFoW9I3Cr2K2uGjJrsMH3te9gqMtSjWXR5IkLN108Fh63tvro9X41DCJvt//N1FO
 0daUuZWq66VEuJYlYwSMQTkpRvIhpr9N/kiKlHlY9SlrUkH98p7Rzla1sU7ex9dn
 dLDWxBDI12KHmNIkc7UZjaMWj/dI60BE/hu6T0Ogc2hELkoAxpBBVbPefPXm3bAD
 pjuoqkD9WDP459LD+2gMQydsG7WCrErR12pH+TIvkyk7b59bplXjc1+hx3ZLgEek
 zls1FewViGUlgtSmEVyyFBGQcoKOjiaE9cm6ssaGj4yo/TIZcpeQFWEtA4C5SxzI
 bI6o5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka615h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:40:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5476f5bd009so1498031cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 01:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793612410; x=1794217210;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0RisWK7U/ImCk7w0ULia5Tu4LqGc3vPjywy19ERXZsQ=;
 b=eVa7nMWY1Y142CuCq94BF7UyPZPKjmhM+YRAGvCtNL3jORSzdg0go6n5Hq3WZEXWPP
 PDS/UaIJno7DNMXnzGWJB7n6T5QWNMs2yUBDS/TztmcffWP7y9u8EZRgTF39GCnTkyeS
 KS1CjdK6N9Amiq/onWeLrQWdaFt/WN9eENvXrxZ+J01DrLcOvaLUcMVPEX17TH8lgUYf
 fTEnYyR2D29se49KJdTjY/MDzxmObVP7lxzTzcgJPuy88KfO/S5sdITBPnGmwTYQ6iiz
 o4lZFJygAYsyXSp7fV3RSRbtRUQHJYUcUkWpe8DBeZ0n270qTDICY47NJZAUoppACgKQ
 40wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612410; x=1794217210;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RisWK7U/ImCk7w0ULia5Tu4LqGc3vPjywy19ERXZsQ=;
 b=zNTq4TBhNotHxTek9Kywe3jVOjpA4wb/j91XSm7F3GW0JjmBWKisWx55ZB0zQX10Ue
 lPkeRLWXHgb2FQ8y75uqldyO5p0WZgsL4nWZftQIT7NN4BfHO+gtgq7tp97vlAyt7a4h
 0WL3wB9SYBpIwSCO4j4vEgbobLkT8aJyGWRPg+W360g+Ix+MM4OYucNpqVQRIkS51gGI
 VRtb62C3qSi/1nWz8J459f/7M7DCN8jvjcRv4vkqaT84TwGb43PE6MfKfP/zZqMHKmWE
 qmh6/H/9rgAZIRdX911REZqkvYwGlRt+PH3zENxOmvsw5W25aPJnMudZqbNZyzGXgJzx
 TrIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByFVna9Nf/LDL0CqIEU89lc7uZrsmAe8CDV5+MUUq5WY5JlB3pM48AUKVthzlQOiSv8IAfju3+OXpc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKAlK21lPgCKZFEchrbNnC7CG9lNYq4Q/Je9Qog2DWiZNoQU01
 39sS5kjABUC92AEr59xk+aWZRQXu26qrS9QsduKLrgLAB4epI3/h5w0+/owuVgaCNLKyYbb1yGt
 i1WLcJA8R74t0Y+lI0abviF9nYu499bgH/X3+PyHOAFayGAxYjJJ+I1HXXHJ8VRwecokWue0=
X-Gm-Gg: AYBFou12bV5vzYT5kOKvc4oukcbz0nc2w84SFXr+nAU8/GWpau6deO1Used/lmI90qd
 N6NN9VoeC0jFLP2B22G/H8rYRCL5aVyfz1vOejpMmP1l7WnpHkIvYQ2xNNa3C+5BKDWbd+E9y12
 CoWNW1cGcT3lS3kI8689RH8GTsd2E4osBWVGj2k5NiIhciFcDZ5YKwPBhlbcSd1Q3R2/2D33vJY
 /DbrDlkpQx3l/ktamklskLt6AayLLx57Siy7cV7qbHWMZKA/TckU+WcalroGbxmEwe/xusCo7Rs
 2LQzW3GGrsPHCWJ2AscceI2REUot8NhJmllMcHrr4PbwWJr4VOjpEHcKcmTgx2lA41kdAObClsk
 cTUt7KVoLzreew1RY0RTLof23kmFplSyrJTCbrl+/kdUYKSuej/Le72m480yB9m3VTDxwCMo=
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1568138485a.1.1793612410412; 
 Mon, 02 Nov 2026 01:40:10 -0800 (PST)
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1568135085a.1.1793612409919; 
 Mon, 02 Nov 2026 01:40:09 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd195sm364609966b.23.2026.11.02.01.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 01:40:08 -0800 (PST)
Message-ID: <90ae1b4e-d83e-4209-9df1-7ebf778a881a@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 10:40:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/gem: Fix VM_BIND range check
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261101174911.25184-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -SJl1DckeAkTHGJ_z6bCTIKUNfDDu_Lq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX/CItKoWE56Nt
 BSRVRVtu2S/KQSJMLcuKXkD4m4sRSw398ccc2TmneyYtybcsc3vsaBDVFSWFGZi9v3GBk0H5QQx
 BmOvOu+h0I8sU5s+nFRI5aBlxfbqeqo=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae85a7a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=chFjt-TYfWtG2qqLwSIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfXy8Z+z7RYjsVX
 QM974KMJWDypAOxTrF3NV+19NN3UaS3Rp6SDrLr3xrhVSTN72V/3ajAXueIgHdmT4jNToNXqpGN
 VWFJGHHaxGIqSZ9uFg9W3nUq0OvpjB0lzQlK2CzLqgfHjQKd0sbuRmRMR8GBRYUrwPT2/tibgPR
 9/OuQ2JlfkjDmUSbd1oI2JsFpiJG8mbCx0DIflS6HdxImSASNijOakd+7zZDr8XNmoKaMUswkwL
 hn7mSxs5pF/YkVOUaQjWM0vqRQ2jMUo7semh603twUMWeuuQDKZr5r8dDKWZDtqo+xsEE2hHsrU
 B1RF0REM10uRHRtQHDsyw2GXDM7p/AsxC+0CJpSaVk/Rq2YaM5jiWb+sB/MZSyNqs2UYh3nUb5g
 QdB6zFlGk/TXvUInPJSbk+DGsLYpqeHhlTie9d/gzaVJAXs7l+eDuA8pjsBvQlM2iF56zyvd3TI
 eoAI6Xa8Iu7YIzPS0aQ==
X-Proofpoint-GUID: -SJl1DckeAkTHGJ_z6bCTIKUNfDDu_Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 6:49 PM, Rob Clark wrote:
> Use size_add() to guard against overflow.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index f687a629629d..16b3870d5e90 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
>  		op->obj = obj;
>  		cnt++;
>  
> -		if ((op->range + op->obj_offset) > obj->size) {
> +		if (size_add(op->range, op->obj_offset) > obj->size) {

GPT and Sashiko are unhappy about what this does on 32b

Konrad
