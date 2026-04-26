Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012FDFF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 12:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F412510E023;
	Sun, 26 Apr 2026 12:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBbizPPP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9nJ8xQo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9F210E023
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:16:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63QAwKc5970973
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Eu9oH6bIm++6Uod9f6mbJENn
 f42CEvq9lNDJEscrW7U=; b=eBbizPPPtjcY6DIrYbD6qYZQ/8+0igrIAyTfcwSC
 2yLd3BCGUJpCMiKlxy6zams0+3OjqFHBp0aJjN33GRaonbx/5ebBPOzM+6SzH0Aw
 GMwo/fZHT7+NbrFqpRPXJ9vdPQwqOa9NDGIMFenynmAgcuqgrZJ2YB+/EzpYloN8
 ldDQhuRtuxGtRWGbST7ny9qWjUaTWIi9KYCFCENx1i5M911mk2ig4aYJoy3uWZDp
 6OEm3uysW64A8vJFyXbz1ssVSD7ubC8zOvTikyMqDvt5Zd8gkqa2GExmeVtJrbj0
 Hdkd+dRKBDngFXPSJlkB0z5Ng1h8QTm1Su7eQ85XiJn1kA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drp07jsx8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 12:16:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so162766341cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777205766; x=1777810566;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eu9oH6bIm++6Uod9f6mbJENnf42CEvq9lNDJEscrW7U=;
 b=E9nJ8xQoumJRr8UYmFmGpCbowjrZkDpjVMNk1OqRc+fWcXLAHavGz9T8S57OAi1EFt
 Km+hsGzmLLiuf+Ykl5IiPtEgQKv5ooUgaXDZAaDY74aEX2rN9nana62lWX5BbLcLGHqi
 EuYwSpaKX+ISTzSH87Lp1hJo8skJ1xwAcQxKhb/BoaGtW4GPgc1qkFNomAB3XXQuYgm5
 8Ea/AnaCqxn7y0IhW1ZPCkb8SAr/4yYfewKTi81fWwtu67QYcuL+6jnhd87iiQHFCyKK
 m7UXbvP8aCIS7hO9oMB1Fl1P9s8se5kJA1Sq/gD/xA/cG63zw4V9U2uwJhDVuQCRtqSj
 xNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777205766; x=1777810566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eu9oH6bIm++6Uod9f6mbJENnf42CEvq9lNDJEscrW7U=;
 b=s7kviuIlE3gB+B1ZO+uWIQYTQM2RCRdWkUHCU8JaSwwB40021OcaWj4LDioVGCVR1k
 uMzr+q9g12fHRbb1bxFdTmlFxGZNOjuVpWzgZ870SgbscgW/XCfOI0LiWZbj0pSSXzkM
 hq0nwUhbSk3Uk12pH/6YCl01HGTVIIJhOTLO6vHnEc7ZX7OE7ySERuFwWCqkQH4Dia6C
 bMrjcCvjYfiqEUrLgQ+NB1DCrrfdai+Mkb6dFZEe9xTIkXLKYMT1jhwhzWdlWuTDw94M
 mYqabdtEo+zgaAMX+ZI0Mpu6XBgIuWKv20rU7a5emCW+DXINdlrss6tF3xgQG+ILAim0
 ocxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uFJvijiwzxt8RkXHD+kFEQE0j5KllOuUY53QDMRqdPZg27Dkv0/JqXX8fVtvupVcQfOf9LU+BB94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuW4b+QeTlDZE+ry2X5891cOCzIDakJddGLxndJLlNg0OE7Irb
 J6m1vAbDBwtv2plRdLzc4YnTcJXIpUPdcM+ryw8GEEZjWEs0WseEpPAypAm0ysvSlKRkwG7j3gV
 1eZAB1AQ9Y+JwIbtivqseM7Ks0mhV0SuQTzZgmrM24oEW2IAbQpDjIDVumitMMkofl3ir0w0=
X-Gm-Gg: AeBDietyMWnun/i3zPMq6NqVyPnlVlreTYU6RDYIkcJE7zl9/s6IrkiBG2TKSdz8yQu
 IA4/w3RRtaUMKjUj740oNE6LZTsrb2DvkMG2ukDp+IRVQ/s5zUIUTmp3KYLBV5d04BV2FANMY13
 GKtpG/9LLQfhprCJUx6bBm1/qLNfP81p5YxSzsoYs3khhl+VwRUmFwRhKWmyV76VzpaYFm1nUT9
 +BuapUAC1e4OKEiFlKNS2zTxBJhU88W8G7o1kBlsySsv75lwxZdwpmFzvAFYyrStWyFfsgv1fpp
 WYQMyrQDL4ATKmxjB6tJsYs9p4txIaHC3YFE9AMvink7+fpn9fZGbco3Zc1BWsU1UI4O1GEHPsj
 0jRcfQGAuopCq3QVDXx9pPa4ID51kbe0M5alqt53ZaWJXlqWUGr5QLD/tbabMicz3ZnitIZtXSM
 HHaOebNW0v6cG15GbiED4wlphf0Vu5eCm0YVnQ65vX2JSn7A==
X-Received: by 2002:a05:622a:698f:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-50e5de873a3mr285408391cf.57.1777205765924; 
 Sun, 26 Apr 2026 05:16:05 -0700 (PDT)
X-Received: by 2002:a05:622a:698f:b0:50e:5de8:6458 with SMTP id
 d75a77b69052e-50e5de873a3mr285408211cf.57.1777205765441; 
 Sun, 26 Apr 2026 05:16:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebfd6sm7326187e87.78.2026.04.26.05.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 05:16:04 -0700 (PDT)
Date: Sun, 26 Apr 2026 15:16:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 11/13] media: iris: Select DMA_CONTEXT_BUS to create
 firmware device
Message-ID: <atmot2aw26hrystaxpnjtc6fmep2lsjdbarlfocysghl7db5gc@yrdyk6i6zd2p>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
 <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>
 <2026042305-pungent-urban-c681@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042305-pungent-urban-c681@gregkh>
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=69ee0206 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=FZe96GFAMPEOsOiVEGMA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: v1RtJnHPp7A438SlK-MAT9bGaWW13gE9
X-Proofpoint-GUID: v1RtJnHPp7A438SlK-MAT9bGaWW13gE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDEzMyBTYWx0ZWRfX+zsO9bcm9v9+
 Go92UqfIe32s48WGrL1EcgqPCzwaRg98kSoPvtEcEUoTeYS3Z1bA7ycfLq/KCdjPgiMJgraoeR9
 AOQBn6Frud6nBllmWZaawSHqN/lV/tvSXW6z9O9DYK3aERyJ4KkMRG0i/msf2bcGiV2g/MfmNHx
 2lfMiBO1DpMJHs8lJhN4+z8nYfLl9geaMA8vEOPVZ1pjBtwwIOw5m5u6//AbFKS4uAOpttgXLKM
 zlYClolR0w3MZZpM1JJuT8Y/MHDtMYK5QV5AcShbjqxnoS9XTaqCG8fyGS9WrdBFm5l/NbBesV/
 aPe1jcMECNaTH2zRgq4QT9Z127SNk9dTmuoiWMNkoQId47B8u3d5zQhr8RCBMG9ucSpNjj19875
 vCBt2BB4kUSsU71oSja6ZjFFqpW8Z/Amj8bpKpyBZlRD2pRFPOdtNpowbWOpyF0fZoKLEViXWDc
 OtfCyaZmmOuSwGP7j9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604260133
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

On Thu, Apr 23, 2026 at 03:38:25PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 06:59:40PM +0530, Vishnu Reddy wrote:
> > Iris need a firmware device to enable secure PAS (peripheral
> > authentication service) support in case of non-Gunyah.
> 
> As gunyah isn't ever going upstream, why is this an issue here for us at
> all?

Vishnu, this is a nice example of why we are always asking for the
complete commit message, describing the problem that you are solving.
You gave zero context for people outside of your group who don't have
a knowledge of your issue.

Please start thinking from the reviewers point of view. Or consider
yourself being an engineer in 5 years wishing to change that code and
trying to understand, would you break something if you do this or that.
You need to explain, explain and explain things.

For example (please correct it, it is based on my incomplete
understanding):

If Linux is run under the Gunyah control, the hypervisor will set up the
SMMU SID for loading the firware (and protect it from being touched by
te OS). If Linux is running in EL2 without Gunyah in play, it needs to
take care of that setup. Since loading the firmware requires separate
address mapping, corresponding SID is describing in DT as one of the
functions inside the iommu-map property. Create the child device that
will be used for allocating DMA buffers for the firmware and mapping
them to the correct SID.

Please review all your commit messages from this position and adjust /
rewrite them as necessary.

-- 
With best wishes
Dmitry
