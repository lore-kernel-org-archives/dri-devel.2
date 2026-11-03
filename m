Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C2606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TtRFm+43;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fMWMMOgA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F92310E7B3;
	Tue,  3 Nov 2026 11:30:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1510F518
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:30:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAV5n2201918
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 11:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xq9SJGooGMkxiXASdXOQUDBFa/yXYeiSSIq21wnmgbg=; b=TtRFm+43mkhdOS7p
 3xzT8ukoiVZFxLgboLbyziImNglLnXKCV04/vNYgNWs1jb6k/1LCbvpoKumIz0oS
 xqkw8Fh90T1FssXYax9/hFM6ZI1QbBxkCugDQYKUUBaac/jFVYj0uR8Oe3/3FRFx
 H9ybX3xm+dykDMebMWwvNSMAIWir5r9Y7ludiWMkAjvTLXCC13WFP8bCu0xwQgVZ
 5SggYrCxIWaDAHWghi4Xn/RrP4Qv+9cRDVYP9mNXnSL+x0sC7H9E5P4jwm1x7drL
 t0ck19WmKdlUmOP36rI2LgL8dc4JCm0rMaVscQ+ijW/PYAuH5790TEEkP9ACcfTI
 mTdfMg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3gap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 11:30:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944102381acso37761185a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793705425; x=1794310225;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xq9SJGooGMkxiXASdXOQUDBFa/yXYeiSSIq21wnmgbg=;
 b=fMWMMOgAbD2XxbVgn+/kqbg44QaPhhd6b4xZuRVT6PfFOtWSDmsGeHxUBg+vCSMYpK
 KCLCkJwNMBMRgQjTzRd9jr+M0P7qrxu+pgal26hYCt0fdbeIthpN3JQL8DZ0fcm5Fol/
 wHXgakh/tGFlYR/lyQzNOoZyEjigdLJSIV7izPdTpI8DExHkIBhc0wyEST444Hz38K04
 Vjo8B9RUJSb2C8r54ShZYKpz9/q8UN6Xc07G/5oE0hlaBAVFWlY/oZrqzOlfGfDRIrkv
 eaxDqz9Q8RgOa4nm4OVMcT4tLDO4gHQqU4R0KRCcNQdRAKgiUi9l/zJCa+ji0I1sYDET
 8dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705425; x=1794310225;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xq9SJGooGMkxiXASdXOQUDBFa/yXYeiSSIq21wnmgbg=;
 b=EP8ZkN2LUjnlP99xMyqjNU9cXQYvUOmXjF1n9lOjJssEtBQlIAocgxL4/sP3X4plOp
 glZTimbWhZw4jggli2jZc8HnpSau8DaOS0IErWal2LkbhCeCkIE3UVRKPhwPJjPaXnF2
 lYeSUfl5+Fn3NTMjAYvp8e612nOLuiJRtS7V8SlFiNmwxwZqxx0WPTY/O66lFHzj5YX3
 v+4D8jzs2poHbkYuFRc+Ia1wQCqjgPmX/zLL1chsSafV5W5K1tVQRxbBdYNbfHJ6oand
 3+iRbS55VmtP9AD5JiJYnCy6IBORI+1Ek7RGL/V+ks+2PpY40xDCGwuNuANd1WQAcjHi
 AAvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrAqaDq7zScWyt8JR0Vz6gsynBKyp6KqAZW1bUKeG4VWOeRtPReQk7UyOuF4xt20giHO+zd2QZFLM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8WOLALDjp1I4Dp1VxBXrQiVe/DAj/1W5scGUW+NS67k9XLXDNe
 oYzXrf/WvEDH8aeJJDjle4qX8paiKAhCqPNsOGxsSqi7k48RX8uSQNGz0D2P4ElQfxkiqcAR6XS
 kEqcIF6AFWmC2Hj2+W1HQJZNKjL5jOoH4w5vgS1xNgfwKd0yBzZ95bWY9zWshAUHMfHhi//0=
X-Gm-Gg: AYBFou1kSFUOBhEBjfrRF5aTef3cYGKoEW8JjRbUTcbt9d8ven90p0wLSrU1czjyz3S
 4Nvh7JqRuKNP2qQtk9+C2p82CULKnugUDmt1HdWZPjcDf9plF3RTl+oTaMgH/FYJPsN3TjRVDo0
 7gJJbJCT5lXNvt18WU2SYf2OlUeyAee3/8B9cQkgmdSkbxe3JKBRrulG2AFXjhfhKvnCYrXgdM3
 sRMg0WYiNMb4biWoKJUYPiEHyjrjd64X6surIj6BwoQguv09X7/rIvfQgRWaoB1vUu6pNJM0t5Z
 OvPD9XKmhufL7X3L4bs2AasuUDQYIfb6BIHPqQ+17kcSYfo5rIoJBCG6PI1Szfte42Ue+/E2hR7
 mCVoAKf2BfDvKafxotnesgNIuPIgmKKwS/aq2xScdbKkY1fzuva+Rs8y4aUxicyOKhAC70Q==
X-Received: by 2002:a05:620a:a7c4:20b0:945:c3f1:4008 with SMTP id
 af79cd13be357-945c3f14cfdmr411367185a.2.1793705424703; 
 Tue, 03 Nov 2026 03:30:24 -0800 (PST)
X-Received: by 2002:a05:620a:a7c4:20b0:945:c3f1:4008 with SMTP id
 af79cd13be357-945c3f14cfdmr411360985a.2.1793705424067; 
 Tue, 03 Nov 2026 03:30:24 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebefc972sm76300166b.35.2026.11.03.03.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:30:23 -0800 (PST)
Message-ID: <0574f915-51cb-4eb7-9d6b-49ab32aac553@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:30:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/msm/a6xx: Restore GBIF CX config for A640 family
To: Val Packett <val@packett.cool>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261103011358.65398-1-val@packett.cool>
 <20261103011358.65398-2-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261103011358.65398-2-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: j95dIsn2DBoxqE8dlC3Ock9RvziqcBcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXy9nFyM0V3FcT
 q+EJGVfzDcFYnYd7guBZdcSvu4z4Srro6l7ryAjtp6uOD1xlJjdIJtQXBveZjkpUMsL5Ef6H4GM
 NeqFZ2EI5AfYHAwiw4KErgQPIdZAFS8fQ51/OIfuFXOtDvaW4O9X+BxihhWxrSAZQgtq3baHunj
 HLIGpljtYRYqrWLifYTfVxp0/b+YTJjQ+dNR4emDnM+dkfmDP9peRequQejM3IE3zEgnspzH62e
 0lqi02Y5JexHzjGRr1bTuObcl/oflu+OBwNGbNjHOclFBNXovZfcwsfLkYaIkeAeSVXWzjaeMb5
 OjZQgP7QxqgXTJF2hK2uQ3DCvdWf6KN7tki1laZKeizHDZ5JTvhy9yGTOGzzBIsIaavxnoYDhaQ
 lbYf6pf8tD48TRFz7Lt3keRDQ21isYCvInug7l5lhn2wKJAlmboE5MIi/Ve4losEZB1iSb5O5qT
 3d94YXy7XhiydZ+Ccbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX1Zp9LArxC3Ez
 3S5lr5GIHmU/Qm/7U+Vlv8Z0762vU6aVfYS1a/N6ZYmXH2aBa7zplP6L7Rv678rKDWVq7kFHDjX
 na4eEuqKLso1KiFrqk5unkAK60Dqvks=
X-Proofpoint-GUID: j95dIsn2DBoxqE8dlC3Ock9RvziqcBcc
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9c5d1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KkZ6ciwvikuB05GOVvoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 2:13 AM, Val Packett wrote:
> From: Maximilian Luz <luzmaximilian@gmail.com>
> 
> Commit 60a4e18e0e8a ("drm/msm/adreno: Do CX GBIF config before GMU
> start") moved the GBIF_QSB_SIDE{0..3} configuration from hw_init() to
> the per-GPU catalog entries. Previously, it was applied to all GPUs of
> the A610, A640, and A650 families as well as A7xx. However, the A640
> family entries (A640 and A680) were not updated with the new gbif_cx
> list, so the configuration is no longer applied on these GPUs.
> 
> On the Surface Pro X (SC8180X, A680), this results in GMU HFI timeouts
> (e.g. for HFI_H2F_MSG_GX_BW_PERF_VOTE) and GPU lockups shortly after
> starting a desktop session.
> 
> Add the missing gbif_cx entries to restore the previous behavior.
> 
> Fixes: 60a4e18e0e8a ("drm/msm/adreno: Do CX GBIF config before GMU start")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
