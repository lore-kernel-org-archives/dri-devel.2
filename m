Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17A606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lyzXtAuw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iUEe6oJl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B26B112A8E;
	Fri, 23 Oct 2026 10:24:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CA1112A8E
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:46 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAWM93560971
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xaaScOGIozAWpXbcitdyI9ltdmgfQyDQm9ySsdDqK+0=; b=lyzXtAuw69wpYjha
 pMHrUT0p2kEBkfcfdpMFEmya0cZYYFkuD8waEtPZn8eSr/tFf/UHh7wMg9W0Np4o
 3d9iggS27yhaJeSrOQ6pGSZlwTq9eOiVgulI/UDTpDWy8EM29oaaZGV1uOlASvA8
 kwb2HFQImTUSH6x1r6SMVcF3H4w454jZ+R1l1+v4Vk9PxELDM6SRh3VwYn26SuE/
 SvhBafkK+wOhQTeFBat/qk4Ssn1uqLpzhtei70N1fvnIa+CN1j7iD7Z4Y69tjTl/
 BX7+LiWbWT6S6pg9H0EZp8Hj3FEK8nSdUGBFhUECe+RQn8XylW8Ksy7ugFrVwRKR
 FjBZEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmpb6rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:24:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93df7a9466bso9570585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792751085; x=1793355885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xaaScOGIozAWpXbcitdyI9ltdmgfQyDQm9ySsdDqK+0=;
 b=iUEe6oJlBcbq9W3a4Su9tfTGj3i2n5zCrENFMnZn1eY/o264X6k1tyaxot+MQ5VhHh
 KN42izjPxUm/q6HzHXtaL+0LiVCM6/wCDiy4zLmAAUgnxigxosxWVrk6ipLJsY0aIfwj
 lTZLyu/s/3QdHliLcyOBZq7pdnPJcdV63FUSZgXa0+OSUCgKlZWJewzPIFBSNANWaSU/
 ANhSwv7GYpBDQYStn+MtVq+DV0v/X9ubpP9YNVp3KSJQc2x5mbWH8dgqWk4MfEu57cNz
 8xS5tDtSOKsUD2JkRaAEm0Rvoe/cLKpS/9iLR5uWEj34kcq53HidpTTTSDFcDCcvv6Bm
 yBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751085; x=1793355885;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xaaScOGIozAWpXbcitdyI9ltdmgfQyDQm9ySsdDqK+0=;
 b=md63UZ+stMGV1WOm1XxSDI3nz+wy6mQg+FkGnbbKSZ4jp3wSV3kkmFPghuCvW/rGdk
 /P1f3+CHxHa//iA7E42gO8BHCjZM9kyea6tS9uX6x0S6CUNt3onz0tgYWhhOyb6XN62f
 mFiNCQRjpfq3O3jg+EmhwCSnHlMz5fZylamYe3YMGQJVT4JyW0+enPSSU96bdhzTt8Zp
 XjCzv1mTE5NMSd/kK/dIZoPOhopwOatkOj7mt4DMVGDmPWkYeaTDXHMAznZfBc6X2btb
 +nIIS565eO5MoS3L6wNZvwYH2QqOHJL22TNc8laTSzrldejX5068WrFWIra9URA3sZ2w
 uG+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGVzCWMyTrSUpFcuOK98skjKSQYYm9ewk+WIWXYQbQ0oVkiB9P/y4oPwcwLBUXY/la6fhAzwltadk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/icFqyl2KjpJkJQ0Oe808R2Bn/V05EtLG/Ko4MfwvwYOmzWqT
 bNwKyHZ9yFS6RFIJXtr9pb78SmkFj2JtC4yeDDWtQJtFMtbeiPzfape+CMowC7fe2n/FAXzklSI
 Fqarh03Tb7M/6Yz/KICp9YIbK4Yl+WrarCpd+sQYJlAap4CE3zcs1TMOB6U2ah6r8P5W5/+M=
X-Gm-Gg: AYBFou30QkyNQG7zx1WmvLsT/HB9FgdimXGFC9UrESwc2CCRyqZW3JmvO+ZIkuGB84y
 PlH3p9YthZS+fz1kpKICRzEdD+B9jZ6iHgJLKvLwxoPxzVYUsnaKRVbgiv2f10+SrFTnuuhMD61
 ayKXFmUv5tLW5n1LIKMorOlKlOUwP1N+MvAS2tQZyWXd4LUJ0qT56S2lo09SdugLh4cSvUUTfDh
 NH3K00hEvI8ZwG+TbCd6F9mrlcDWDNE7k6+XJkD6UpSJV30bRAlo2nVOt0wrUthoVbvGvbCN2l8
 g0FTECpusDzr6C7jJHNX3n7nbfWBsJAVH77s6tNlNHc/urCW4+SCHJFsRhEucC+XWYZ2EQpu64j
 P2MVLtr1zPYZC+2otR3FECg==
X-Received: by 2002:a05:620a:72c9:10b0:939:c7d1:7471 with SMTP id
 af79cd13be357-93f6f926212mr320692685a.4.1792751084532; 
 Fri, 23 Oct 2026 03:24:44 -0700 (PDT)
X-Received: by 2002:a05:620a:72c9:10b0:939:c7d1:7471 with SMTP id
 af79cd13be357-93f6f926212mr320688485a.4.1792751083725; 
 Fri, 23 Oct 2026 03:24:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5cfc82csm85128166b.81.2026.10.23.03.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:24:42 -0700 (PDT)
Message-ID: <050e53da-4e95-4c45-9b8e-ce3c816fbe90@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:24:36 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: kaanapali-mtp: Enable
 DisplayPort over USB
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
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
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-5-b5ae8e6083c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-5-b5ae8e6083c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX6wNq9KcpsSsT
 xaLP7JcX5tBKx4Wi7hjoSIqFMAwyhLHX03yxeyxwuGJmedGgtoYX5cC06/iMpfzyD9RGaxlCjd2
 IT+W5zow4u9jpVDuT0lxR1duNMTkbcU=
X-Proofpoint-GUID: GUdPKMYtuYFJP_Vu7_34LhuPN67HslrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfXwTIR4/VXNB9Q
 c3R+ZPcUP8P7pnffN37g3RTXMuTzS0b5mxKIWldMPmp9iOy5OQuRks8QDvVqdMOmbZ89DXrALkb
 jkNGw74TYOnaG1po6VkULFoWTALLREzvRhdW1z/tOUbDJglxWGXHEbicKDnbrQS8o7AjV/JKMYt
 h6zzlkWKm8dBKeoNPEBpxktZNEK1jFsp3tzv9QTFsWRjyrLCfXbgNB37nWundIyDJkn6m/g3ax7
 3c0TBhQQ/P9lfxPxlwFrhWUaGluyPaJUissY+gONAF1J/3/HNOjU4b0low2tqxd8XZIaIgqi3VA
 nQ51Q7UdtajEbLs3ft46SK4EZGslIUO+YT690ygL0qNaASq9NzKgpEcp1dqs77AKaJgmBr+YfaL
 8CazK3M9EnXKAySysNtum2PPjPooRicYVXUMpDAYdeOyqhEBw1DSlxFICPnSAdhSo1fkUFKzlxO
 2KzkwpET5YLb4Be4vmQ==
X-Proofpoint-ORIG-GUID: GUdPKMYtuYFJP_Vu7_34LhuPN67HslrF
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adb35ed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9izfxpSnjEJMC5M6MUYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230040
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 11:49 AM, Balaji Kalkonda wrote:
> Hook up DisplayPort parts over Type-C USB on MTP.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
