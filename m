Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AC606A339
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HQUiwcNl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPF5jbyF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB3C10F3EA;
	Tue, 27 Oct 2026 11:27:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF1210F3EA
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:27:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeJZU1427419
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gnBYF/brT+54VvThiXNBFMsUkIWFN5n/zR+vlh1db8Y=; b=HQUiwcNlg3brz6ri
 CV15WQafTLx7qjzv19G0UAoz/qk2r/MrDavXXCnMxcAaO6l9GH68gIhEPU8Ariy4
 Kfm0SlIfx7UmWB0O1wT6NKRj6qeS6tjn7jplPrNtWU1sLINM0qZSuJD1SuUhcD+n
 qNSiiMEUqB7cwNBlIm9dV0tcS+aLWuyY/FCCH1gbwHL8L1HNhXT8YNSjRzFBMsdt
 Ve/QXtL7pEHxwP24JQnSi46obVFXcJV40d8N396wQakDynE1mlpe2gn9uIbsyy6w
 gqHlsNBvBdTNZaILenXEc3tkoDvmdCisPh+wboCxl44jWxWPLDIdr9gZ0etZZR5y
 H3YCfw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbb26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:27:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2bdebfc5so120055185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793100444; x=1793705244;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gnBYF/brT+54VvThiXNBFMsUkIWFN5n/zR+vlh1db8Y=;
 b=IPF5jbyFxVTxatXwIGqQouDbX9fLMrrFfguNDOKlV6/Psi1G/EMIN1xoCpnkLLjqI/
 qDxvSMcOrnrAkN0dErDFbpgv20mWLkGPSLLfmMAX8RA/INwkB2T+N0eLLn/lltxqhMZz
 Sf+LDWWhIeGsm7qs9wcVVbBFXQiQjp2n6gsnJex8hxA68Mv8DIsuCquX6LaRt8gyaH4S
 VqbEVFQUjkkzCGAkdZFIFcqWyh/ZRmmhPjELpc1bG/A0whW1XkUC8m5gEVjkuf5AMp+b
 H99p7CdMJshcjZe3hVlqREfuEv4PYfO6YnRlCn7InIcxW849Mw5+NKOK+4NOVG0vVsjz
 lRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100444; x=1793705244;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnBYF/brT+54VvThiXNBFMsUkIWFN5n/zR+vlh1db8Y=;
 b=KcyeQZjo7+QBBhgxC+CsBA28fCG4L4q9z97gQFFY6NJhWhyEj6CXMvRpFSx3WSmEGA
 cQxb8hw5IkbTVeRZAkJrFcGWoEASsIei1QECRqLpDezRkhaKCssTcXFU+9xxp7C4qYNq
 YEhbO4e0rFV6olaq73CJH825OvUk1FGgM0ZvO/VJdcYJ2hsE00HFh2c4+3yAFoX6CZiT
 axs5OtETBAVvh/KpPvpJIXVp9EPYY9k6YuJFuUqPDyc2zpsM/OUGq/qeBSMSpe4bXfeQ
 wgcUVhcV+LgBNcBtCzoy+STJM7jrp7rLkNw1NUHwHDNdtFjUMG6qOtH2+EL3vKmFGfzZ
 4Bqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Qzc6XYxRBrfQToD57T1KDLWjvIjhGdRiSDVnk39rVKH1snP/BFhriBMWh5FvDcKrPsJ2EfjJTOQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/N3qpZNn1Ox/Llj6/P8I4HPd0S+CWX8UdioMGca5cqr5x23s7
 gwEZ5aAb+nuRfpfGxRFV0amDXmEzY+6PaXfMhl61+On7/cbfrApE5HOkQ5HuY1V8evLP/Tm06Hb
 /Yc5czjV61A9vJyMWgnxO/0wro/kI6hufN0lZyJjtFVpvkRrlg2QSP0zPNcZtlZrWWYiXLcU=
X-Gm-Gg: AYBFou2UqzENznqeroSZ60W1T17OpzA+aIqFYz603J4suC/d63Fdo+GwlPeb3K79iDO
 5jIz5MXFEqpKphB/Gs3fPCDbEg95lv2Jjktu1EOGKNddVS71a6gcF88cPrDEc3nusHIBID50Ga3
 nnV8CJxhLPUhssd44NmFt08ZdZQ8Fa0T6MJBE+4cjKcjdaigEIPyjTafuup9D4nZ8Y/WV9ghgQr
 1yus/oN6MBiXG5WnlGQPv1tnnFP7bDcfYO8UHFlejjIB+LGOQ/usSaoSItkG8+1Cf4G0K4enf8W
 0ufvI5UF3DaDOpMG4OfmW1M4t9e3F8g/EBCO9HPqT9CB/9GGspcy7U2fhuCLaU5ndoZwWa1E/oi
 DhJ8zT1ND4cG7A2KWGzhk1Q==
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-940ef9710femr1762507685a.6.1793100444268; 
 Tue, 27 Oct 2026 04:27:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-940ef9710femr1762502685a.6.1793100443839; 
 Tue, 27 Oct 2026 04:27:23 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4459713f9sm4946374a12.16.2026.10.27.04.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:27:22 -0700 (PDT)
Message-ID: <7ce4f890-8850-4217-89e8-cbda80b2a5f6@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:27:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] drm/msm/a6xx: Protect the 0x1c800-0x1e7ff GMU
 range on A620 and A650
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
References: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
 <20261027-adreno-a620-v4-5-b0095e028c76@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-adreno-a620-v4-5-b0095e028c76@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX2DFur1DumFEn
 oIb1SVWx1nbgYnlogFE5srBEk/Z5UhDLTLuzb6qykG7K/RpD+KejvNtSawMH+XFlXKvrO8AeV1r
 jicQuG+8Zig3CXBK9EoPQfF4DBwmGVU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX5g5JnMA64e0U
 DXG5yoZe9GIpOq5/3sE9e9NS/BnctcN9uvtxQJQNrr15RNo9MRimR4DMVCCzxd+V66BxjN+dD+o
 00dCSoE/MSw6e2w13XrmTCQ+19LrrBzQPryx6HsS7kRgW3MOcg8yPdtA5EUD/YEoIB1AI8UX89j
 Z39sHrHA9Z9z4bJEC+BBUIBEbIJS9b/YG5ravka0zs/tpOAgh3X3E8BcKY+8uN9PTGGsrx5CtVM
 VKDXDPDCe7wZ19gj4Fht54GKSASHB6CSQaXMtNxm+koqwMsf51PKEZIsXhvjn87GFzr2HzidHjE
 Cn9HxfoLF2inL+44LI5xcDbtp+2w4exzw9U9CvdUg9+wbctU4jVexKbWDlzx5hOUC1BwLGP5pOj
 p01XSDIM6OQ3wg85GKiXhkQIXABPh3gXtgPmu0dGG4lprh2iCmgpdriE1VMGfbxWHOO0q86XdmP
 jNoVA39i4w16gL+DL0Q==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae08a9d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=Tm8wa4UmF2Ix6aBE:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-zc-H5WaXjtm9W6SF9YA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: kp_1PGhqbGmryH0KecrniYuYZBc9tthw
X-Proofpoint-GUID: kp_1PGhqbGmryH0KecrniYuYZBc9tthw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270045
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

On 10/27/26 8:14 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> No protect entry covers the range from 0x1c800 to 0x1e7ff: the entry
> at 0x1a800 ends at 0x1c7ff and the next one starts at 0x1f400. The range
> holds GMU registers, among them GMU_NMI_CONTROL_STATUS (0x1cbf0),
> GMU_BOOT_SLUMBER_OPTION (0x1cbf8), the GX and MX vote indexes (0x1cbf9,
> 0x1cbfa), the DCVS option, setting and return registers (0x1cbfc to
> 0x1cbff) and GMU_CORE_FW_VERSION (0x1d3f8), see a6xx_gmu.xml.
> 
> Add the range as no read/write to the A650 protect list, which A620 and
> A650 share, so that these registers are reserved as well. This follows
> Konrad Dybcio's suggestion; the downstream kgsl protect table of the
> OnePlus Nord (a620_protected_regs) has no entry for this range, so there
> is no downstream reference for it.
> 
> The list is also used by A621, A623, A702 and A704, which I could not
> test. Tested on A620 only (OnePlus Nord, a 7.3 based tree): a Vulkan
> workload ran across GPU frequency changes without protect, fault or GMU
> errors. A write into the range being rejected was not tested.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
