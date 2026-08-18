Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43276C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A381110E9CF;
	Tue, 18 Aug 2026 03:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmoUky8+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lb2aSOvF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F40310E9CF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:49:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I3iRbi1171927
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cSsOQKdmDY+6H5Rq7yKqDY43
 lcWOkS/eE/giYEixucg=; b=VmoUky8+H+tjDDwaT3tM/4TVnvJkBfcAcpBpHare
 Tf7ZwlFpTALetiJ+Fvm0LbqbSRc/dZGRFfa8pytEQjoefL37MLLuERLHkEkAUiZu
 Sosalko1f1YAkl7/boT/E1TtemNYToayV0JhE4ZrXJdehbCVBfX38x66O6lpEn6Q
 a0a4W8cNuILfixuWvnT0a+fTX3Vp8HRfQzW3s/hv0DlBr0Mm9piiL5Egb+ZdMJ2e
 jiuRWF7y/EE5Gz97gPBHwxkVD4Rjycs+S+VeZcMpgB1WRsziKUe0s1XmcyloOdiQ
 VP9hSUNqfVcT32jHu4iQNKS6CjrBKG0ukVV+i1sdfVUs4Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmr0gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:49:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso57265031cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787024996; x=1787629796;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cSsOQKdmDY+6H5Rq7yKqDY43lcWOkS/eE/giYEixucg=;
 b=Lb2aSOvFRAvxZB61NQYKsSe09AVTnxglsx4AwqqvMIm8+Mn30hjQXLMaXE7KjyQLfr
 IXDrIhV3lGsUrxjCLNRld9rft0qKnru3FnpgZ0gyfaA4Wji5agNwewGB1RGWGhCwOjd/
 PC1/y45lE8PpIgc87RzrqeKt/z//rQTvk4mM840+upNQZtYnvgAWyvLETSYXRGvDETTy
 D+g8I0uvxj8Us+NLsfsmjB0jXwxgPzTcYsbJoNhvsZjlMUdPSnQ3JPElZFo76ap3tg2p
 /x2PF4xcuiwqYmGD2tmZToA8T+/dARdR6uRERTBqSVCPmiK6uVVxeyNG9G3/oXtfDvgf
 +Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787024996; x=1787629796;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cSsOQKdmDY+6H5Rq7yKqDY43lcWOkS/eE/giYEixucg=;
 b=UO1sNSdjoeGz7R4D1f7stiGaOSoq/aOqUAzvEoqPdS7Hx85Nx1hMdLo2Oe8GPULJ0e
 puKYsqZuhLMD6KzLhk5Luu55vzqutd9IkGuNrAuyVZrp0Viy5Y4rSYl2XvP5/nEvXrZg
 MmVIUwZUALEkw4e7y5ayFsIFK8ZSTbxBVidLeQaCQZFQJ5XyLTMVqkFUCZu37C2QiCAX
 /oR+PRpp3vz9m5RXJgQzW/WKCITPELP2dtKKzST/fvD+vjwytK0pG2yd8NKtBLUMXwoL
 BqsViRVhoRY3C/eSUhcAFn5Or69kwuoVhnHK0VBrsgK3Ln7TmIg16kDNZhYoC1KmlQeT
 pflw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK1xyJBKbKpeopiKMEc86YElXU3fuh/W9pthcqqyDilLdpLp6DwFPci9QyR6YOrW7l33wnXWkhNoQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwyRK9emUZrK0FlQ9s9tjnCBicOtHI8YsNxn48ecK71hoEX7kh
 crZIWgOf12sJwEoEuU771jMovTUKQYwJL7lSZF0VAbwSCdVKOIYEqzZ4vXuZTp7BoALueaPuLk6
 3Tpzfy2waYpSY4z4DTMZ7x0869j+gy0z/QtF/d78W+0y4VjPMplQV66vm4D9QKiuQ861wV7w=
X-Gm-Gg: AR+sD106fxLk7UD6+kZgr/hjTXhGK0CV4oZoBVi4QwRrO+gb9ejVJmqstPDbb/4mkjq
 Io8b7P+ideX8uBiHi7SChYXGj/6dHRt7KpIRDKsx89RLgnDoXi5FFJfKu2i6QYqUG/MDenI7/Ma
 odlE72pvahVRENprpErum3Zsh/G66ezBESeCf4fLohjx8jLJoN3DzUwzBc2AEzCFA0d3seLW1eB
 dBDtxH3NJ+NzTsumUfCO7B/0QKL5VMvNEQKIbhfKU6GGQUYjKDtN6srWB3Z8dkYzEp9dwav57gl
 8MeHuUXkFu30/j+GKc53pl8lX2Ewa5G6cFXHg1ei0dTpoAG/x19YYpjzK2soP8sWMCROnSUR9/J
 Eh/OCQ86fBsa3UgNPa1/t+aGDL7BQYWgdsHP0OKO+ng1+Hfgs/k+ZrCb7NBtiZ1w1p3mtQweQtt
 42pFP4L0/ISCV+
X-Received: by 2002:ac8:7e91:0:b0:51b:f217:539f with SMTP id
 d75a77b69052e-52d85354a61mr315349461cf.17.1787024996076; 
 Mon, 17 Aug 2026 20:49:56 -0700 (PDT)
X-Received: by 2002:ac8:7e91:0:b0:51b:f217:539f with SMTP id
 d75a77b69052e-52d85354a61mr315349131cf.17.1787024995589; 
 Mon, 17 Aug 2026 20:49:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cfa875bsm875722e87.32.2026.08.17.20.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:49:54 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:49:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 10/15] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
Message-ID: <tjfcsz62is33iphcwtensnoiohhpfk2zh43qfe7ijd4b2324pk@v3piffq646ac>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-10-69a02e9090d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-10-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfXyHi3MQZmjnaA
 bvb+vUz8/Wr/54JoSUuMPFEDEfld/WceLPsSlZ8xtLm/59HsNrMH6n0PV1+7ENgIoJNHojCbrwZ
 EvZeX7+RpffsaZWwS2h1QF5otqLjRrtRnvQjnmWNjD35C73GUJuoZe/Vlbp4n7uiYDsM+b4+tHh
 Wi10Ty6PhU39XkjR0RIkUtw9l3urlHEz1s5JrbZcq1Ht6jxtCJW5pD76swt3kMbFjXmOb2Rb7KD
 I80pnaPokf77LNZPM2K7oN4hFPeaX+GtxsEbXCYm5b8yHzVBz6HtAPYmlVr2k4XkQ4Oh9FztxQY
 At6138Gx1K/lQFwhDapU2qK+EvlKwDG3W0VpCnK/zKayi5RcK0CfM0fFlihmk4moTEEjozOZXl9
 fWaGduAGeOSC3gpjK5rhOVrUtmHqKJn/WmUpvLV0nc2JfQOZ9wqIayA976Nf/EP2B5DGSyREauv
 fK00xNEImUW4xsBe8hA==
X-Proofpoint-GUID: jHECoULbP5XCpGqxDvSXbSfpHyTZqcfU
X-Proofpoint-ORIG-GUID: jHECoULbP5XCpGqxDvSXbSfpHyTZqcfU
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a83d665 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=eI_CTGzUyT5ilQvOjN4A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX2sG6VzAxvF0p
 diaaxjXoTyJwW3pnDllFVLdtLPKO4iKxy7qVc3PH3SqZOQKav+3vUGYQU+S6L4sHC/pwv8so3U9
 IZ/Na3KcA3CQBjghAOYsVlVDCbMCJe4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024
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

On Mon, Aug 17, 2026 at 10:17:45AM +0530, Ekansh Gupta wrote:
> Expose two new DRM IOCTLs that allow user-space to allocate DMA-backed
> GEM buffer objects and retrieve their mmap offsets.
> 
> DRM_IOCTL_QDA_GEM_CREATE (drm_qda_gem_create)
>   Allocates a DMA-coherent GEM buffer of the requested size. The
>   memory manager assigns an IOMMU context bank to the calling process
>   on first use and performs the DMA allocation against that bank.
>   Returns a GEM handle that identifies the buffer for subsequent
>   operations.
> 
> DRM_IOCTL_QDA_GEM_MMAP_OFFSET (drm_qda_gem_mmap_offset)
>   Returns the mmap offset for an existing GEM handle. The offset can
>   be passed directly to mmap() to map the buffer into user-space.
>   Imported DMA-BUF objects are rejected by drm_gem_dumb_map_offset().
> 
> DRIVER_GEM is added to driver_features now that GEM IOCTLs are
> present.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c   |  4 +++-
>  drivers/accel/qda/qda_ioctl.c | 50 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.h |  2 ++
>  include/uapi/drm/qda_accel.h  | 36 +++++++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+), 1 deletion(-)
> 

The patch LGTM. THe commit messages needs a rewrite

-- 
With best wishes
Dmitry
