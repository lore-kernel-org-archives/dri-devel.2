Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C74606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCbj/bq/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5iU4h2G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D0110EA0E;
	Wed, 11 Nov 2026 14:13:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6F710EA1C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:13:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABDIFAP1343647
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=llfh8etuwqMEBoatS7BG9atT
 A4vpv1pJNPCbkPuzpyI=; b=ZCbj/bq/7etR5mduMsXYp0jpAwQ/AZdMzdYdASci
 VmMJONZ+iJEIUbANBiDjtZphcWabwse7wGo9h645cixX6XcXKZ/uGGfPLJ4JCERB
 e8I7/d5uvjtX6Fw9P/v8ncTMUJg6MECCmrpbVV9qB8RiuOe8CAEq5tV0DSgzvrXS
 ey5Gg1BPNsa8KT+NcxPxPlnh+AJcYxc7TyWgZXzrM+P5SfYUHqybWuG1ftpAHVZW
 5w25MerOy+XYX+KP/GioZbvtfeBkosizv8g9POZL/G7BWgPNt+jueA+IlNyGQM38
 I9qm7lpjucG7INeL2Za54FsOjajj4386I+7u307pJIeOXw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m07e8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:13:09 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9907de400a6so517385241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406389; x=1795011189;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
 b=W5iU4h2GIl1oi37JLS4hNV6SDiCVTvaDdfXilgkrgFSoFvadNXJ1IThXWsXymzIJZF
 b3qbZp/G34I/BDx69jiLffHnZyRpC/y2o8oSveuQUzA6Nulz6f48QCsCdEcFTbhS/ZbU
 jkcLRHiijdXr83D3dlJupHOsAxQLPNQQS2nP4aqmJM0j9p+9/iSfCNga4o7t80BLA3Ca
 +bBiTSDUJA3LKinu9cBp8DYmy7HIdeI2GbYqz8CRtSyYKToPUdSshYlQs+upzsSLskS6
 KMUwgaC0eVMBpvQihpBIOFxxT1ynt5WseXl2i1JYvwv35LzNYsNqfb1SSTiQWrpJSVJP
 d8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406389; x=1795011189;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=llfh8etuwqMEBoatS7BG9atTA4vpv1pJNPCbkPuzpyI=;
 b=sWLm/i+mA0RkBA6KuRc8/PQoW45Zcb4PHiV31MZPpjyIBELxkY05x351kgV0MX71Aw
 ckiYBV1lREyXKcdVh0ix3Lpj/h8uxxn86hlkZ9e49EJyxkvn3UXlHGhUG8c2wpQwsT2n
 KSV9OiYVdIVT5WXEnymCAy5vLHvxA0/yMt3a7B38fzOS3VngH78pkMvmgPdHjJs712A9
 WqZAS1rPgWWnwsi7WacZm10TkO/oLBjoc6Mw9RnmPfv6RoARXU+tVh+LsM+2RZDtjbXa
 7w/tkS6FL1zB95Q2twlAxAuJSyvwv1PfJpS7eybmTZwjPZkAzUrbqbilnDZApb27F3nv
 iJ1A==
X-Forwarded-Encrypted: i=1;
 AL+hErHAchdyVJCbnJsodb4XF4sTnrRXbsXGoyURbM/T7BqFxKpMwGQCLXf0pmZ11VX37EQJ/eGBqCCbo8o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2iF+rOgGySGzGLieekvJa9peoFWWMKl7JH/MKeuxsxObcuf0w
 Qluu8tq49kBchc7lRoNWuGwl45X4ka5W2N9rdzX3NHsG1GXOWfFc+EEerfiln+alxSsaWktXXvN
 D1wi0xJRcvuvuj+x8nVwip1sPWhmnTMWBJ463KlUKHVhoKWETxfZAEFkW4aQ+tcAoBQCYoQM=
X-Gm-Gg: AYBFou3QtdpwJhWdJBnwf15PM2Z6z03cZW3/kGsc7S04e80wiYKCRlyFI6aAuNjrvFl
 spPGL9ubuJT4O8qdk1xKtVhHtISzZ/DtLqW2YXnrHU81gnUNSU1M3VgFCL0O937MwTFcwu6pUMu
 7VmFv8FAkDv+WnJJM49l/0ww5dVjIhahN9zPsJpDEZFzhyEtX1sX0H0V/x/tAm6VMFKy2R98CtK
 jeGn77uEtk47zvCakuSsYC7DQgee01iHvoqr9LfT2o56NdpgV9lKN+4+l748cOmqqQGoKgwaC8T
 jkkZv/Be1eZrIYuUjTN88bm3oJ7bjVOpGMSHD2lODov0mukXXJMMGnsjv7PPDQUkr+rZ70GO/qF
 1XO++J62y9HdSuoY2RwbG2JtYg3phT958TcpcjeYNAr/WE0Ew30PSNVf8XEMxYzeZrwZLwoy4oC
 sn7dY0A0EEINKwkRX+TN8bT/PoOLFMTqIef+bkY+DKQ3vzI7uT9JkAi6lAIEtClA==
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id
 71dfb90a1353d-5ee1c462ffdmr791581e0c.16.1794406388851; 
 Wed, 11 Nov 2026 06:13:08 -0800 (PST)
X-Received: by 2002:a05:6122:1b09:b0:5ea:94cd:c5d7 with SMTP id
 71dfb90a1353d-5ee1c462ffdmr791529e0c.16.1794406388144; 
 Wed, 11 Nov 2026 06:13:08 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bb7839sm956114e87.74.2026.11.11.06.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:13:07 -0800 (PST)
Date: Wed, 11 Nov 2026 16:13:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
Message-ID: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Rjf39L28Q-X5XBfgXQUBYMS4bL18FEY3
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af477f5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=XCsYekLr3cgse1I9aysA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: Rjf39L28Q-X5XBfgXQUBYMS4bL18FEY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX/VQoF7t1OHXI
 JI3P2bokwTDM/2to1iT2xIywJrMmdPO+1ADLBMPwROSAOVOAfpYcqTZVctoVfI2QN1kBhWm3zF+
 Ftsfv/ne7YQib/HbqVLoIjXBUYI1s9wTAT2/Jo5Yav6p/GwmKQDzvamkNben1+gwo3EqNPtSrge
 GY9cTMxokgIPfISu8u/PBfK2/u1C/lFVvjUw4L856sCC1XxzWjW/es0p23T+iE5ZawlwMT8nkfh
 KnTbe4Q3UIzYXsdwOK7+FZaIXQcCNja1nRtDZAW49Uy+iHtC+wH3SRg7FozBBsWmdVFBh7drJoi
 fOPkPA+zUlxu+tDWGGMNm5WTBuu5ikVoZtwliEKrHSCUITrAOI6AIS3zlJaxJPD1vY1tCwzbZJ0
 vnrKNILEHm1FpM5oyXInQWsZQSTDIWZHVpudQFlJI5g2+1DGayvN/4+NNjI1OIRWBmVu6RUKb9f
 Yv8kFh2zExz9gyGFQrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX4qUuLHlm1yQp
 HqYgXoJUhbNeJr/yxrrbZvtu8FsX/8LCdaQBh7O//PeN2IE5/8x98ZLDYnP/vXRJxIjBw2z9lJ7
 pvZ5Nb/uYdm7BgVXGNUgQOrM44dz0XI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
> 
> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
> > On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
> > > DCP platforms place the display pipeline under firmware control, so Linux
> > > cannot discover display resources through direct register access. The DRM
> > > driver therefore needs device-tree descriptions of the Qualcomm transport
> > > wrapper, display topology, IOMMU contexts, and panel connections.
> > > 
> > > Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
> > > subsystem. Document the IPCC power-notify resources, transport and
> > > framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
> > > DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
> > > after the IPCC power-notify sequence has completed.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > ---
> > >   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
> > >   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
> > >   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
> > >   3 files changed, 334 insertions(+)
> > > 



> > > +
> > > +patternProperties:
> > > +  "^dsi@[0-9a-f]+$":
> > > +    $ref: qcom,dcp-dsi.yaml#
> > When adding DP support, would you add more devices at the same level? If
> > so, we risk getting a warning about multiple devices using the same
> > address.
> > 
> 
> Is it good to model each firmware INTF as a single interface@N node carrying
> the INTF reg, with the protocol-specific DSI or DP description nested
> beneath it?
> The driver can then obtain the INTF index from the common parent, avoiding
> duplicate addresses across protocol types.

Yes, it might be good, but it's not what is happening here. You are
adding dsi@0, although, I guess, INTF is 1.

> > > 

-- 
With best wishes
Dmitry
