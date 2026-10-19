Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5175CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367D210E178;
	Mon, 19 Oct 2026 13:23:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01A510ED43
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:23:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P9001666883
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8hblxjZ9KBP0XKSNbf5MNxLLDFs4xig3vgWNCXG8XHg=; b=cWUMyhg91cLKb5Fo
 STmTeq3iSmi5B1Wlt4PFdpEKCKXgAT8Sddinsz1Wtes3oYW994NV6Qr46w3bNnzi
 /BMVTNfNDJEMkHUNHVFH/TD0FlNV7tnDJpBhvl1WjvIkK03ZI5o9v4poNPfq1hnH
 FKpfhIMua3oBt/69e2rELIp6DNSFBBloizOqiBZvAu0Nyl0SLf1Rm1pSioKpr5SK
 CQgIuyRU62cJMnoMQlUw7U6VGha64wiKRVAMA+FUuszOZyfeEkgSZCcE1+dH/wfl
 iWG/5/QXSqWfsf1nLav42dk8gx99TpiQX7cuy4a+/0X2Zh7WbuIVEwEKFZuGJm/g
 4xaexA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3n19gv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:23:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1440e081so30827385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792416222; x=1793021022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8hblxjZ9KBP0XKSNbf5MNxLLDFs4xig3vgWNCXG8XHg=;
 b=gIFO4c89spPutMRCXrAbKP56iqsKGNlCZDl4sfueihY6DVXV3iAd23Mx14VoPMZ5t2
 iX0M/ww/Sh4RWEAOOf01+sqUZsxPc78czKW7kWmNalEHN09CkD/6U/rALY9WY6UWex2J
 qUs4qvPn8dmkBrThB6a/SHQ9dLpPdd1BxNGDznHxeZHL77316Brlo3f6nZJoejsrFc+V
 tHr9t1PMsz1XU1JiAVuA46FELQhYdT1HxmgHjmlsC3YTN+aj5onvqskzeWgBnOcZIMy5
 KB1BLqyvfY87zeJ4TUyIz83FRkLO3qRZ6G1GXz2+Ncvm3ABQOhaPLnBlyWAWvxpB3wvn
 60Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416222; x=1793021022;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hblxjZ9KBP0XKSNbf5MNxLLDFs4xig3vgWNCXG8XHg=;
 b=aMCo0jUOZDf3OxoTjnk9DVN6q6sRNsp/8kpwubu9VtCjw5Q20YFOCdWs+SH8npzFq4
 URdsr85HKvjedsSGA3NlhqLfmpaS9sSHjR0slv1+cEtUu0664P5cnwXdtq+1BMoIT+hj
 fVE/PL/T7iBotQfT0Wuy+4qdQ6LB5Gm7Bjaw8B1w4jBQYcDP3xd4jW149ns+PXgFCqjX
 owAUiWaqMv2z1VYlLykZHikekrIiuosuC9kv6ZR5PK35XJkS7xyGW4MZbjYs9GkVVKcc
 uI5ZjZtaeCS5UNbm3Jj1quDPXxQSxgRO+FlJve6n6FVkndtYmKFIYokXuwi2LoTM5tkJ
 4QfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywO+BKFWjsa6FK9+UBTyKMZ7WJ9VgrznWI7kLtylgEM0FnaA/+UXj8WPIk9MeqeGYYwA+CSwIYXzw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKc7aS4LztbdGjdmLkhKOkqDMLm5mE0nRNavOzqXUk4PkI83GOd
 jgUcc3vSKetph6A5aaa73zpjrQIH7Wa1E4XGw/KUhYWxXrMwv7ZZIFvutaJAP9yt2+PVeCAX2vx
 IHKTnuBm7L27Uyf13+L+kBYSKrlKc183aTRqKJNIC/FYF0s9+dHjFOccT0NokHpuwtvjU4nw=
X-Gm-Gg: AYBFou1FCC1MiJqLwJTqGLR+7dtekTq3LodX3ZxyFvxoDKJQNeZB/wxrsMAcx295YS/
 gLdPhXQUTJ2UnAM362fwCeqDKyIcn7u8qFWo079nSZ81tmgC8g5VTHGUlw9r6enM/tKxQdVthbH
 N631zLn9Xl2od7PnrfbcmlrF8D2cQrPD8Fa+LMvK3pWMcwtaedminzmQ4XpGZTBHCaljEei80un
 +c2AUL1+4HTN2e4AZCAVWzetlYcVR0FWYNGRjCUDpFA12OOATYhekZQHJZ+FXuLAqDwamlCd6ye
 SSDVa2Kpq+fOXCaf76VsO1/u1E5co94u4fSxDoJxgrUNl56Vi4U/0OwEoVQhHPprJjoa+1NNQLz
 Khdp5rsBoey+/52+l0HetRA==
X-Received: by 2002:a05:620a:800b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93f29ce0b63mr1507860885a.3.1792416221994; 
 Mon, 19 Oct 2026 06:23:41 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93f29ce0b63mr1507838685a.3.1792416220282; 
 Mon, 19 Oct 2026 06:23:40 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dceeafsm370255866b.17.2026.10.19.06.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 06:23:39 -0700 (PDT)
Message-ID: <1cd852f1-ce14-4559-8215-2c3ca7bfda1e@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/adreno: Add Adreno 620
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
 <20261016-adreno-a620-v1-4-4a7ed6210d7d@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-adreno-a620-v1-4-4a7ed6210d7d@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfX2mL6gPARf2nd
 RlzadVUagc1REgqD79+CfB/MTJPYUwPIRPtnSbolmzGWG5hM2oTuht00irxP8O/8hVmLXCauXtS
 nXDf4Mt2H9vVBuDAG/0KqC5c64SJ8d8=
X-Proofpoint-ORIG-GUID: c4-SItkM_F1YFQoPlU361g0JYIY1xJtU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfXxK2GsaktRft2
 grmn+IvZv0O9c9rpY7ud7Pi8t6YUo4JDE2xk4EXnIhT/6g3R/+ON9DMYvcyUYUUqBwJzOQlGuvo
 XAEKlMcn9/7fdx0M7ICCMF4x4JtS9rfRFMFdb828SNhl5s7FpfXETxdmIsKHZY2y5BhltNXSEHq
 +sH1oTlP64UKyJk8CZ6E5Bzua1/9JCy/4sMX6AKqSL8Ai7iXPzWtRIF6aJC0nTxEpANHlEVO8Se
 uPKD5A17viL8jYu+HCzflFbIJ9yLmycLy43COaiG/IO+E7XA7/2wh7vR7oZZk2ToWN2KXcj8kH+
 FfhIw1OgnMHzqKlEMJ9Ib44DjodtdONux6pkFlDQOiL0LsWyrNfD6NBYp5byGErLxlFiwvXrjWH
 L0Ov/ELH5GwDTUBdkwbdG/PF2VcY+AXDNYQ3To8SEHh7JaG8apMEz6/R+sOBJ2gxEW12p7sBWnv
 brv/F9WsHjC4jCkwdiQ==
X-Proofpoint-GUID: c4-SItkM_F1YFQoPlU361g0JYIY1xJtU
X-Authority-Analysis: v=2.4 cv=Zf2IpcVA c=1 sm=1 tr=0 ts=6ad619df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ODsmY_3wxSbvKopP8XUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190053
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
> Add the catalog entry for the Adreno 620 (chip id 0x06020000) found in
> the Snapdragon 765/765G/768G (SM7250). It is an A650 derivative and
> uses its SQE and GMU firmware and protect table, together with the A620
> zap shader.
> 
> The speed-bin fuse values map to the OPP bins as in the downstream
> "lito" devicetree: fuse 0 is the default bin and fuse 132 and 115 are
> the two alternate ones.
> 
> Tested on a OnePlus Nord (SM7250) with Vulkan.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

The protect maps differ a little, GPT says this:

- Downstream entry: {0x1c800, 0x1e7ff, NORDWR}.
- Mainline: NORDWR(0x1a800, 0x1fff) ends at 0x1c7ff. The next mainline entry is NORDWR(0x1f400, 0x443). So nothing covers 0x1c800–0x1e7ff.
- Registers there (from generated/a6xx_gmu.xml.h):
- GMU_NMI_CONTROL_STATUS (0x1cbf0)
- GMU_BOOT_SLUMBER_OPTION (0x1cbf8)
- GMU_GX_VOTE_IDX (0x1cbf9), GMU_MX_VOTE_IDX (0x1cbfa)
- GMU_DCVS_ACK_OPTION (0x1cbfc), GMU_DCVS_PERF_SETTING (0x1cbfd), GMU_DCVS_BW_SETTING (0x1cbfe), GMU_DCVS_RETURN (0x1cbff)
- GMU_CORE_FW_VERSION (0x1d3f8)

and it turns out that a650 should naturally reserve those too..

so please just add a

+	A6XX_PROTECT_NORDWR(0x1c800, 0x1fff),

in a separate commit there

Konrad
