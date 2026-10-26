Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7D606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iG7uEmRH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XtUAsYhy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E2F10EDA7;
	Mon, 26 Oct 2026 10:20:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A84C10EDB8
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:19:57 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b1tK2206204
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=; b=iG7uEmRHrz2nY6ZQ
 qdfXjpFDxtIuoB54amFfslMLk2lyWrApABuyXNM/prMFFhb0eZQTdvQQmSwZSmeR
 P2Itb0Vd3aOACtLYDfNclmQki/Xm5b7/Y/fogMLOSR6c8vuf2nNwnfmnHQ1kxVTo
 8/g4NRErnM8FfV5y9oECOeIGwrLqPaPNkRUOBgxRPR9twWXYqwbMG5Oxh+dnn2NZ
 MHzvISixMZ1cYA4ooKwj247NCQDEYHN94FAzl5ZNSeqqRY1zq/JjyaqqTxHeLITP
 KvojHGmvFYS/Ztl4x+BIdJNMTEK8LQyl2XRwbepebw/VVaXUzGh+TynZsanz9x4H
 yOtGLQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrunwd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:19:56 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99062be02ddso387013241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793009995; x=1793614795;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=;
 b=XtUAsYhy5PrNXGlnYWbtXLUpSbpetsDcCOW0kiuFRf4fTTKlfTVGd5nFPHwLRcR7tb
 /BdBmmaxa84bE/An+lpZRCTHC0siVNiYRHCwW601Jqj7+VwGlQNtvruX4OVMelzjr1HI
 PXDn/nxExMfucnw9ouM55pPXoWS7J7bs47It9jpH7oKeWj5InT35+fsIAyj8p+LPc0//
 iY8kqdvNGW4hZFhqhsTFgaGGrz7feanoCPBSW667/AHCaISFA18Xq2Lmlu00pEfGlyde
 n1+gKYaAzmtAIrNAGJ3mOvZKxIExSmOp9cGcnO0B8J5LQm4f4+JFBNWrjTs8g2FpjWWH
 vbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009995; x=1793614795;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0d1AZOuu17x2UJYa5tXiu0AYveVDNIUyu2EW7x7PGi0=;
 b=lLarOnXIIqc5zWzayU9AfOGmV0Ay+VWRO/eFKO/q5vlEh/1zrG/9VRAR8g+AUgpJSz
 8H9PVinSJbivB/zpTBuId1iGZgjN1AByDMWs8lCwCdXl/uMv0uKn/ahaSh35WRI5wiYe
 63BrPxQHGUSphV2x6xSqWxUMxsd6pRtaI2x6vNpAC7V9usUkObEgGF6NC8tIeFjUA7gv
 rhVSqr8BUbJivvegsFmfadiyYCtRRyrOOsRsiVkbJwq0JLP1W56WbqYpNRunj6RiAfsy
 LlsbUJlex6R9aSXUUm+NDf95JWAsD8J3ODniT+K4mjMtk7mdWLx16snqVOgqqIMI1t+c
 3wKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzalUZ1y3Yh2VmO2F9b1lw+VYAKPinm2jwUueYWK6bKWFtAbKNDeqJUlLu6ZsI0E7QKjh+3aYDX+mw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImlmPC5C1ItCyb4vLPstW7woNwIOU/yIqBKhus8lidmYt6CPCJ
 4RX5fjo8YuJ+x0HmefDTR5pilG8Ld9UNCwVBLXp/n7NrGrdcsxo8gJ208cp6I1E1fwhXCl6vX9K
 Czu/2I8aVzyK1bDWtVkD6k+JLT2jYHYEoIMIcD/KHEho2tfoC5DOSPMNRoF4/U9zJzpfSyLk=
X-Gm-Gg: AYBFou1wyGjYHOGHBCrL5+WUwUvJ84IPfXcVsKnOZgahpC97dKOzOO1apDaZKKueJyc
 JRm7I16ruxiCKPvBSncTKPaaTQwTBXG0CjzewtFm1wulPhTlttECGNju8P+2p6mHvpBU8mP0O3z
 uMsMe/5oM8B+8vdC9kXgBCkW89gdSvy0bPfWrk+zScA0MUUB8uoQh/RnbZ559sGDdGiSGXf7tg2
 SOFMs0e15SHOyBkq0KANVt8jpdrT9isksSJKvOrZfczsuX5Wg8hJOCaD1VqV4D+0m7DPxyrvtia
 3hMNERig/YwZyDpxNPumBMjo04AOffBFI0GJpRkfHGlUikKKnuimE3i6Xmf73kAnUsToMlIHmu4
 KbX0DVPimrfoZ+kNp1mrhlGqGCLGLxOF4ZctlNeB0msS6iHHfxRdApIFpDp8PAEH0gmMMniKjlO
 QhQQJY+frK6ozc
X-Received: by 2002:a05:6102:508e:b0:7cc:1a41:20e7 with SMTP id
 ada2fe7eead31-7ce5cc8d17bmr1599801137.7.1793009995231; 
 Mon, 26 Oct 2026 03:19:55 -0700 (PDT)
X-Received: by 2002:a05:6102:508e:b0:7cc:1a41:20e7 with SMTP id
 ada2fe7eead31-7ce5cc8d17bmr1599773137.7.1793009994712; 
 Mon, 26 Oct 2026 03:19:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a4csm18119321fa.25.2026.10.26.03.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:19:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:19:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 08/13] drm/msm/dcp: Add DSI bridge
Message-ID: <ztyi4f5u7h6bmm6755j3xzf25gvguqswiwwpfm5vj5ye4sfl5d@t7vwsro3kewu>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-8-48aad0fe4f72@oss.qualcomm.com>
 <hftbao746gtvza4vkmeo4jvvgrgzoyrifdpsu4w7vcy4w5qskv@4afg7wpdw6gm>
 <a27903fd-c122-4ba1-ab84-fd3fb282fc77@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a27903fd-c122-4ba1-ab84-fd3fb282fc77@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX7RFNIqxKxbta
 yddVDslsM8PkAWN9mlxfy8ZVaND9ypVfy93Cz4pT/kgmf85Is+eiha8j1Mt96L652OmjAZAw3Lf
 +JSMeixxjL3x2JUl0fiogj4tYT18kpEkWHD81qMszr+Z7jbQJRXWNyNGd1YU4gWMBl5c8DCDaDJ
 nR9kXuJR24RNTbP11d11nkJAHem4WoTAVyDq13ywo6YIaQreAPuUo6IkPWUgbf80jteWCNJiTPl
 Vu2MwClbvFxvReoUPpQ+WA3/GxxigMimDRgJPCCBtKZXMI4SByTXHW/ujyTvJYS6gW/BSofm5pH
 Siuhf2xvxbEihs6zlcsbazD9ph7v2xMggfysQ7lZPFV0verj/3ai6Z0VN47JvQtcRnTVcom1C4P
 c7ylu5mtx/WHeapm8yxZXHbZsXeW1f73xEd4yfsWl4Q/38rL+/Vx7tD8aQghMApO7p8ATCjUaEI
 7Yiksh+Ae7j+aDnz2Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX6xY6ghLI85+S
 iadPGCcexXUv8QZPnaXsovmtWoDFmWxjE0ukuZfBRxw2GTavcN4rEr75D/IsPQczDL+zIJs/VF5
 gGquyXi4LZhiF1/75YaHwpSGqTHOsqw=
X-Proofpoint-ORIG-GUID: kNrjitgqMUslm9Li530QouB083Vs350x
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adf294c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=B2W7agYZx9Fm13VZOvYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: kNrjitgqMUslm9Li530QouB083Vs350x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040
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

On Fri, Oct 23, 2026 at 12:47:10PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:26, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:28PM +0530, Jayant Shekhar wrote:
> > > The firmware owns the DSI controller and display session, so the DRM bridge
> > > must translate panel and connector operations into DCP HFI commands.
> > > 
> > > Add the DCP DRM bridge for the MIPI DSI pipeline. Translate panel, mode,
> > > power, DCS, and display-session operations into HFI commands, together with
> > > the KMS session preparation and CRTC integration required by the bridge.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile             |    1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.c       |   14 +
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c    |   45 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h    |    4 +-
> > >   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c | 1140 ++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.h |   69 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.c      |    8 +-
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.h      |    1 +
> > >   8 files changed, 1279 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> > > index e7d24be72113..9910bd4f306d 100644
> > > --- a/drivers/gpu/drm/msm/Makefile
> > > +++ b/drivers/gpu/drm/msm/Makefile
> > > @@ -72,6 +72,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
> > >   msm-display-$(CONFIG_DRM_MSM_DCP) += \
> > >   	dcp/dcp_crtc.o \
> > >   	dcp/dcp_dpu_kms.o \
> > > +	dcp/dcp_dsi_bridge.o \
> > >   	dcp/dcp_hfi_core.o \
> > >   	dcp/dcp_hfi_crtc.o \
> > >   	dcp/dcp_hfi_dsi.o \
> > > diff --git a/drivers/gpu/drm/msm/dcp/dcp_crtc.c b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > index ede81881d495..fb8920d44f8a 100644
> > > --- a/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > +++ b/drivers/gpu/drm/msm/dcp/dcp_crtc.c
> > > @@ -147,6 +147,12 @@ static void dcp_crtc_atomic_begin(struct drm_crtc *crtc,
> > >   		return;
> > >   	}
> > > +	ret = dcp_dpu_kms_prepare_crtc_session(dcp_kms, crtc);
> > Do you have the session mechanism described somewhere?
> > 
> 
> The session is an HFI display session created with HFI_CMD_DISPLAY_ENABLE.
> DCP requires a valid session ID before accepting destination-ROI,
> plane-property, and frame-trigger commands.
> dcp_dpu_kms_prepare_crtc_session() finds the DSI bridge associated with the
> CRTC and calls dcp_dsi_bridge_prepare_session(). That function opens the HFI
> display session once, stores the firmware-assigned session ID, and publishes
> it to the CRTC.
> The session is then used by the remaining operations in atomic_begin() and
> atomic_flush(). The bridge’s atomic_pre_enable() verifies that the session
> was prepared, while atomic_post_disable() sends DISPLAY_CLOSE and clears it.

I didn't ask to describe it as a comment. I really hope to see some docs
in the driver.

> > 
> > > +			dcp_dsi_bridge_get_mixer_count(dsi_bridge,
> > > +						       &state->hfi_panel_config, mode);
> > > +		state->hfi_panel_config.topology_enc_count =
> > > +			state->hfi_panel_config.topology_mixer_count;
> > > +		state->hfi_panel_config.topology_intf_count = 1;
> > No 2:2:2 support? Can we just drop DSC support for now and add it later?
> > 
> 
> The current series supports a single DSI output with one encoder and one
> interface. It does not support split-pipe or 2:2:2 topologies, will be added
> separately.
> DSC support cannot be removed from this series because the Hawi MTP test
> panel requires DSC. DSC is part of the panel/DSI configuration and is

That's a hardware problem. Use a different panel for the initial
validation, then add the DSC support on top.

> independent of split-pipe or 2:2:2 resource allocation.
> This series establishes the basic topology and HFI/DRM plumbing needed to
> validate the DCP KMS backend. A follow-up will add dynamic mixer, encoder,
> and interface allocation, including 2:2:2 and other split-display
> topologies.
> 

-- 
With best wishes
Dmitry
