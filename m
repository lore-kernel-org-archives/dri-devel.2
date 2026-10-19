Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C423CCF2E3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6276210EC9C;
	Mon, 19 Oct 2026 12:39:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE0610EC74
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:38:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P5L9724621
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g1Zf5nmoOj9REwHL4lFlJcEi+BQNp7U+4/drZJjgFKQ=; b=VKfriVX6+qAmBvUJ
 S8rJfWLOJCjLIbcmSEVYqEzztxPtl5o79LqZy5oHNHvsBo5dEqLzhI0Rbq8QUBv4
 yYcprXqTM4vdCJ8FPy+oUSH9oSC/uPvJ7ZlTyryUqP5qnFXXYfjTyDMXK8RVdpgn
 cQRhy7ChJwjoYmjQ1BPWNVDeE70uOq31+d7ei4uIaIUpgiblSPihTnRbHj/CksRt
 iSx5UgSfBavR+b3Y0hCrFvT3G0LPYYP5npEQDj9VlCymd32jFu3f3Lg6qV0tt10b
 Bw2qjF81gxaHnF6V1FyvcKsqCV0EutBxEowj0y1q1+dHtYwHk7dKSFRDrdWNjLPZ
 7mUaNA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65h2tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:38:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cac495d99so35655685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792413535; x=1793018335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g1Zf5nmoOj9REwHL4lFlJcEi+BQNp7U+4/drZJjgFKQ=;
 b=RHA+MYF/W+BZxX1Tnn8YdOfirXL8ELKL801/06PDURU1sO+QhAIayaMz0JTVXCxLC6
 0wsZE0LSIfwkz7JokbdwatxhdBeowlf1k7ZX9O6OYFSMs1ihmpjBkhVbEZ9CwuqJRHx1
 9hz8A3lxdjoO22yKKe+MNUnL7HtrYBs1RanLK6S2YXZQrGCPAplCHqTJlbBZNrJkUobl
 Ig64NqzX+P4imLHP1cefGL/9Yz411DcWRGcspfGetva5QgqNjeZiGi8azCcGWVe9D7i5
 v8G8en3DrutrR/0nnS/kOgUWY+Tvgh6x52qrTSzGm4JlBVHMM72llnlze7UtrMkppgkQ
 A7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792413535; x=1793018335;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g1Zf5nmoOj9REwHL4lFlJcEi+BQNp7U+4/drZJjgFKQ=;
 b=CqrhGJR5KrWOnIKvHnJb/cdBRV7RCqs6UEkkN2rxc1e2E+KQDUqOfvpNSq/tpa8rXN
 5QzzUmu+0ZolGFMsja/C1aCTJliNQzZLQm/T6NoQ0WjzxDxlUVU1QOaKholGWDg9Bsz9
 FBBFmdz2Vp30bHb3HY/LBXlWH5n9glDWyqDVuNK9Kr+tKOArko6Lax49t9/82wEL7dX9
 dAvi/VWxKMNL/Ji/C3q0PQfhZC86yWJEWzzgzxQPhXNOO12oEyjdbtTTKPdaj2Uk8B7Y
 PwMDV6AM3c1WSb6pTmocXsINvMXfoHjpzxb3MSfhsO+Ok8/L6j0M7bueGk+qGjopGsky
 pjnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByPNfQBux9KU67MU6JRiHmsAnAUXxqnIA8o1SZ1g2/ytRoZpymECBlx2fzSz7C52q3ZsjXulG3SOIM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTG3OYtEnptVUC12LSk1Y2TFMBPgZzm1fwp/OMSt5WJtW91cJx
 a5qWZzzseO+q6qyDVasFA/U8mthRlvcEqJExRnvQnh+8+pn+rK6Tw/uv5mqZTkl655V3LmwnCX7
 6xi0yyXWUAOSr+pm2zxWKRu8JExSFWmhZPF2SJOcXGULF7NSTQz1MZFE2NgRU71B0tzGg5jw=
X-Gm-Gg: AYBFou10X73WC/2AtjYqZ0Vj7EQOpgzzggw3MChnwvfN5CXdlUWD9CKabyRhlmmszN2
 vg+MxZxmumkaeocqOBeRZ6zonKjaXbn0NJOjipEbuTWqn+drgnU+DTMYc1Fx0I8lquxvXuajMbj
 AZm6r0s5xfJFqPQelPN5E7SutRzeVd2QDkUF8VKLR3uF/CR0fWdlz5fdPnM+xFVxo+pERSRPf3h
 p6CxYoElFlM+lh2bFLkwlZLaOJz61fW04jDtTnKyBeqc7egTQphM//fjqM/U8CfsKdSkJQ4VSIR
 e94FOf7eSQd+T+pxdtLqykXXMDhQfNF6z99ttYg9oeRvelHliIyzuk5+RYVKCdYOZqIzTjUq5Iq
 UmvGPiRcta05yhe2X4R68sw==
X-Received: by 2002:a05:620a:3728:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f29a0a71dmr1436765785a.0.1792413535098; 
 Mon, 19 Oct 2026 05:38:55 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f29a0a71dmr1436759185a.0.1792413534522; 
 Mon, 19 Oct 2026 05:38:54 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40919bcad6sm354612466b.52.2026.10.19.05.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 05:38:53 -0700 (PDT)
Message-ID: <577a1383-1198-484e-81cd-3de996cc7150@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/msm/a6xx: Add a bandwidth table for the Adreno
 620 GMU
To: patches@brar.si, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016-adreno-a620-v1-0-4a7ed6210d7d@brar.si>
 <20261016-adreno-a620-v1-2-4a7ed6210d7d@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-adreno-a620-v1-2-4a7ed6210d7d@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MCBTYWx0ZWRfXwF94aRksf3hU
 DdEvj+jTpiqEwcmp7EgZrCrlaFT53RmsowfNDQKnXkB+7LQhnSEMXx9Xtojfd/wpV+vRs6yd7U5
 mkUVktLFWe2fr6rW1T/pzKfrL879efU=
X-Proofpoint-ORIG-GUID: eSWQPd690MdUsGe4gMbsNY-D-5p7OJCG
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad60f60 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ODsmY_3wxSbvKopP8XUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MCBTYWx0ZWRfX/ifxNJzlTA5L
 AjotQcpLddCBO/fHzT9OcGfozYpd7Rmen29x1y/qpx+U4BWicQhtstYArUD3kzn6tGn1pnLiu9d
 yGIJKqkdJn3unIK7MVeVTQcZFIAZfcun9bi6bcf5GiiNlKkvsm+311X3DPSPy4DCF2LitBRddSL
 Z2TXKnQcDRlU7uDyqDVtdqU1FuEh7NAxrH4Wgz81mtU6t6IRXJqlwpE/ogJQ9UZdvcJBWetZK4O
 OpS+7Jqhu5T35pIP4Do98CFmxWg7fzVs3uiXe4PpSbXzg5P4JM4XL5nDBferSpW27VHRvtdPTC/
 mDDWJKaDeWXqkHp8pOTmso9L1QtZuzuSXeJ8HRMCWHpUlXLIVVugEAZSdKWa1CWYp8tRxd7H21b
 IvrI3S7sgRe+pRDuVP/pz2NOfHQ2DvyBFTVbR0w55bOloISVHnNPNo7Vua5NG9krIuG5t1ebAG1
 tsJBy89jRfVWOERWjXA==
X-Proofpoint-GUID: eSWQPd690MdUsGe4gMbsNY-D-5p7OJCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190050
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

On 10/16/26 2:53 PM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Without an A620 specific table the GMU falls back to the generic A630
> one, whose BCM addresses do not exist on SM7250, and the first GX
> performance vote times out.
> 
> Like the A650 one, send a single "off" entry just to get things running,
> with the BCM addresses looked up in cmd-db. Add adreno_is_a620() for the
> selection.
> 
> Assisted-by: Claude
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c   | 33 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 +++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 6b34e704a..cab7ffc63 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -553,6 +553,37 @@ static void a650_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  	msg->cnoc_cmds_data[1][0] =  0x60000001;
>  }
>  
> +static void a620_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)

This is no longer necessary if you add .bcms in the catalog,
see a6xx_generate_bw_table()

Konrad
