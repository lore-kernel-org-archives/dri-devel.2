Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC2606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpYHy6MC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YR7Rl57Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2386B112A94;
	Fri, 23 Oct 2026 10:25:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47215112A94
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:25:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAYNE2509073
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nDLTzLm93OhSUueXu94d2WDd6pOzTzbQpnpa7vqPALw=; b=TpYHy6MCctn9gNuY
 VAkWRlMdiqbyn97oXIGrk0laU1sQQ6PjxLhpsNojq3+HaqLZNal7MyUye8mWWDB4
 qtqxlLEz14HFLBTK+VHf+UlopRyB8qW97mQnEZCcWM0B8HNGNQFJiOKEC+76Jvp4
 zSHPQBJVoIU8y0B2ojIFzoo9Vyrd6fttN8ARGPEMpR2OdquTd+coUfzQ2CIalykD
 S1JQ+vShGttxC7p9eWi225C8d6S/2PG6a423RsPLFpHg/AkOy8qCtgCsqimgPl4l
 yCE2my6jf+jSOHZ8XBu0HPxpwYqlZqsV6fqMSPpuqFJfhqhIae31I9l1j8L5M6sY
 v+ooyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykanch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:25:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e58614290so15480285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792751119; x=1793355919;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nDLTzLm93OhSUueXu94d2WDd6pOzTzbQpnpa7vqPALw=;
 b=YR7Rl57Zr6lo4YOPx2toYtJ90KSLQtHNh0vg1MUybypHhSlx4aUHwGXUqYuY86jJ/R
 Iu4r33aZHWj2LjqcW+KTan1McLDQ+oBeNWItMgD404/4RINhovKI3ROhIoh/yip4ysFW
 P/AQ2KIOIvqc17ayFzD3FhJsJ86tl31y9bOz3jKBCp+xWF1uTJtNFquWZbyTs7g4C0+V
 TmFQUU357p2HGr4PkIPuvXmKQcchBXUjqlKooe0oq+tTx75fWaZjXdnemZo3QM2+AYA6
 CEQL3CzJSG4wp5uNldDicjmHNlAohMoUOr5gHxjtv3aUOEO0GLica0rXZrBdvGvb8hoB
 aF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751119; x=1793355919;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nDLTzLm93OhSUueXu94d2WDd6pOzTzbQpnpa7vqPALw=;
 b=hHDphrU8XyBY4Nz9Tp8iuFQANhTw9IeuLMP1xjlT98YRuuHR36Uo5bT6bi+fPnvj2g
 SxsbM1DXpUM47tyoYK6yg/6tjVrNKIDq2iJohPoXRnfZTB84/bw9D+uWZBl5pf2vzhfF
 P+rM9RbUM/23YgVMmCbTAgfdQtK4xlkOl4RTWkzYCHpva+X11EKTRR2d9HjG/guYC+VV
 FJG27INLG4tfP5nOOMABxna1jnZhEwGALxlubSqXaGgMB32gyZVgF2nOdgsk4z+vef5k
 WDD2SAFATI3nTBhcO72wVetss/9OZPxeTSV8dqIgXw7hj4YTC72rAl7PSVP7U0AzC/xq
 wbEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFb7MBDp4o9BtARmeyUeRUyUi2Or1GBoxMxldJMHkJHP/jtKFw16OJpeSmPJ515VUxLbkNY2PWVmU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTW20BsyQu4Mw2AGM+lGybk4sIJRmUrZKPtzu98eFEt2WvRsYq
 JzEFPZ77m+JxYtEQWFEkyQpgNRLhJCErhTm7O5iKgJWk6Xc41LgfBx9BYXNehiNyafe3nOUtmm0
 JVctx1hAfPb3l6ayOsst7vAy7fU8hHwPfhQQ9QlyOsjjlCV4DsxzCsDiw8ZlPqbDH1RfqIss=
X-Gm-Gg: AYBFou3JFhx40jmghgeqDfb75lWntTMMhhrVrE7uPDIWBblF2/YLFBUloZ9gS3C3Gqs
 PNoKwBkT/f3U2oBTVF8yWTDD+AIbmRknMzIrZvhY+YhyxgCSQ30MCKbDLiOW8RKZ+k8o6LgvFlw
 X9JoiFzCp6WnNXLiOxk7WeFSTaob6gRGaKlmztiHQUl8yGKmIQRorIC7QV1/MY+PVsxOB1LL80j
 8tjHd74hvAFTKLwHQPtH4NwWOznP0O3pz1aSqmmRyPIbqUFfjBLh5Kaov8Ko4nUGnodpIWL3GlQ
 s8bztr2mJ2DRxRaYO7QEWKd1rHxVozIv9Bgz/Topr0kgnH7uDDzFx1hT790lGF86e9EAWDpUBTV
 zEp54r11E4cNAlH3woWCCWA==
X-Received: by 2002:a05:620a:a8ca:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f6f54812fmr340746585a.0.1792751118802; 
 Fri, 23 Oct 2026 03:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:a8ca:10b0:93e:5a3f:ac13 with SMTP id
 af79cd13be357-93f6f54812fmr340742385a.0.1792751118280; 
 Fri, 23 Oct 2026 03:25:18 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5d181a2sm85208466b.87.2026.10.23.03.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:25:17 -0700 (PDT)
Message-ID: <735b7f7c-b8ab-42c4-ae84-9172804496d5@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:25:10 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
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
 <20261022-kaanapali_dp-v3-3-b5ae8e6083c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-3-b5ae8e6083c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX5pabKKLlaS0t
 D13K22ig1uj/AYAMnxYN7rJxVMMU8FHj1NlaeO7a2lj4/9g7QwiFD9wtg8IcOEBbl8QA6fJyPW3
 YgAxaWbGU28omtCYepdtXgLRQi7oLup7A5NSle+TWU0ts6X4AeYTXMCX+h7FIK+tR4ot28xTSBQ
 Z60ADOMDI1K4dNumfZlrYGQQSPLISPuuD+7+TolD2uOxWMNkxU2eMQTGDDbJciWib8SbTfXwCZ9
 LVA4fpwOdaL1V+jJhqXQm6v+FQ/2ugRsnlvDd0hvPop5eyWAIMaDPQvy3LgHTQiy10J8rfYfPaw
 BdmW9FTRoVzxmQTOoLNEqDozbVyrZ3RjDpfOcGbd5XeZrLtAPgGo6ZRpbqIdpowTuEr33x6VQ7v
 gOAbMHSsN5mQW+VoIoN1TV9sGpL70umwgrRzthiAonHXwMRvtN3k+LPRuHCYmNS3FTiDYYSOmnH
 bDDiFxy1zXMxg4sJceg==
X-Proofpoint-ORIG-GUID: 6GfLZxYWM5Lnf3sc3cYzEeR9N4W7KFLU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX2503grbuIR/+
 8SCw/rfFg+HZNtH0yDwcuzlvZG1vO6zI+e0p/m0zigXCELXS89GQWHFQbDbSth++HxRDdUVp/Mx
 u7IKwEIJ6+iIUqpcoOP1he7I7TYy/PM=
X-Proofpoint-GUID: 6GfLZxYWM5Lnf3sc3cYzEeR9N4W7KFLU
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb360f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=S65zN7q3fX_PurGuIfIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
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
> Add the DisplayPort controller node, including its OPP table,
> controller clocks and power domain.
> 
> Connect the controller to the DPU and USB/DP QMP PHY, and enable
> mode switching on the PHY for DisplayPort altmode.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
