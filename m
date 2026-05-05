Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31161CD343B
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4666910E90E;
	Tue,  5 May 2026 00:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZ8dU3+9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HajFwfI8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D38E610E05C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:35:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644FOqaW1346361
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uQstg63rkYXGjNgJVr/eZxEM
 JU0++JvkQrQ5rgtmcrI=; b=XZ8dU3+9D/jxyc3MX2B8VgXlqVBGwjuY6H895wB/
 zjMsQ/No18/RGSnXtXkh8r7TNOB55yXhHATaIzAnyxehqZQVRtmY6qMgqHO53DR7
 8ZtAsx9c6AiBaR7q8gtuEhoS1qKJ8xltd8mQhHdCcrjFUGxI82Y+depJKiQV2vfM
 gg9pmItgri64DPPU8JablL//u7x+unpSUS/9DOAVzhTu0/GmFPpgbzREj1mSROd5
 z/4u+2hS/RtSsFfy3E1IAa0PYg1AYzGYH3gB24vlr3D/rW4RB+6ttU8XF3W3Kc+4
 KNLZyJB+2ZDBDzwMgfHi8akVh2aoRcZYVZF9xPsTBEzyLw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2x9rta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:35:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50ea1a7a5d0so119860521cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777941306; x=1778546106;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uQstg63rkYXGjNgJVr/eZxEMJU0++JvkQrQ5rgtmcrI=;
 b=HajFwfI80n/2mHHS3+WMXnB8vbTbwi3+/y9vxm3LJtGiePI5TOYU3grneB17Wmk24P
 TCGQXZdwGWDwOYcLqjEQa6yoV/Z9VXFi0y/znZBZhSBZvo1Fr188/Et9X9D5JLhQtOaV
 7UvQfsxr3zpjfqvU8omEBAkparGUntBDqe5nnPMBmzOhb/WvECyp6puLG1bIjwoDgDFD
 N8gDzL2W7CbtkiSMQNhLbjtOpGMma+RVFgTEfdRM/IX3MCYKo8r68+4A7+T0Fz555uyF
 +O/vVAny6TOdISHu20ufTvr13uuykmquXMSJLHuteIlCtRtOUM0hb7goTi+yWDUM1xUJ
 qdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777941306; x=1778546106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQstg63rkYXGjNgJVr/eZxEMJU0++JvkQrQ5rgtmcrI=;
 b=C7Zc6FhzoisGFY6l0o179eMeSaNEJDsChfbjRIs9PwbuyZFOdZs7omV/DRG9o511UJ
 RrjRupqBlkDbSoAd3kZ36lo9kNGXQWxTsEfjQBFq2A9ZgNBzqxX6HW86FWaiPZMgp4Xj
 WlL0ZgO0wTGLJTx+oTrAF52SQjj0ZKRp0DbJnAS0oQC/JVr7M09XEOKo0piIddtLIzjX
 0K0q7Gu+R8FvTmRpNTV+kmXG3HUMPt6vvh1Lv5dWTSG5nx+z2QIQI8VEE21PTD0B4dCA
 gRq0UjoSSF0AYDeJ9UAlnXaVch/i6KsnC7/u0EF72n7tnwSb8Px1GQYiohuud6c9UV/P
 P3+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x8Brd/5mZeUmm7o9Wh0d+zN5QgXeGMkuwdQLkna4oBE9svhJoYDA+446xPOj57bX2P7ekC66aY8E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcMcu9UXUtPoRor8+Mnz08btYU9+DI6hfD9NsC9RhvJhOXltpu
 98ySvyxiLXUDHUhuzTuul+i/RFote6U1/VtqpkwcUKRW1oltIQNlHF9cFZh5cLiLsHsuUn9CCt/
 9qWm36Lql2FQvAen7KhhzHgPJ/pGNrkKoq63Ez9sKw3gj8waRVj/eNDXP9i6PF45lDYYsdmY=
X-Gm-Gg: AeBDieu2UWj/BZa2rzrT6RL8KwhTyyrDjhO1SVAMXbH5ty7PMSZ9feOcc6fUMbFBdHw
 XRpY5y0Dditi4dKfcMnZsedAgceyflDywJPj1cAErKiHF6xswsRp0Z8TihDYId02sJcFQJhpnWT
 BGib8Ud1ZL3M+sIyUUNISp1Qsm/Vx1kixCr4AeY6JB1Q0Y0kh27SyklRBPdCx2ogiz4nabXo0i8
 lDgvOBXJSpiR3WIzQhlDGZucwGgFZ+/EXgNgeJECNIGneEz8sPcTvw+FReDiJsCAoG+MLo//cqB
 1LSsIbhKhRDl81c6aDx6RgxRYO1BGTFqXGNr9HkgMd1vq8TQI+vWVzwz0wObU02vrCXI1VRFQCu
 72wg76ORrXYOvurDWX+GQ6CxFpX6shIQLF1Cr9PAMb3JOqlqFRYc7zwAzqA4x0c2tIbRCVV8t3V
 +/sYvNllJtOHv6CgFr2u8tERVOspc/YBAsONzH/TGNeNDzbA==
X-Received: by 2002:ac8:7d87:0:b0:509:4406:44e0 with SMTP id
 d75a77b69052e-5104be44e30mr177321891cf.27.1777941306318; 
 Mon, 04 May 2026 17:35:06 -0700 (PDT)
X-Received: by 2002:ac8:7d87:0:b0:509:4406:44e0 with SMTP id
 d75a77b69052e-5104be44e30mr177321511cf.27.1777941305716; 
 Mon, 04 May 2026 17:35:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a864c6f16esm2684204e87.15.2026.05.04.17.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:35:04 -0700 (PDT)
Date: Tue, 5 May 2026 03:35:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
 uma.shankar@intel.com, arun.r.murthy@intel.com, jani.nikula@intel.com,
 harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, tzimmermann@suse.de, sean@poorly.ru,
 marijn.suijten@somainline.org, laurent.pinchart+renesas@ideasonboard.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v3 6/7] drm/connector: Modify prepare_writeback_job helper
Message-ID: <kfizwa7jgdyuqc7qxfpgjjfbqydpziptkhrfrnz5umrycahbte@zlqsjuipu5u4>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
 <20260316083008.87466-7-suraj.kandpal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316083008.87466-7-suraj.kandpal@intel.com>
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f93b3b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=EWaBjrTCu0zT9WKhau0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 9lEU3LiFX5AQXJNd2KMMfDheTrk60Zub
X-Proofpoint-GUID: 9lEU3LiFX5AQXJNd2KMMfDheTrk60Zub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMiBTYWx0ZWRfX9i1pz6MVUEV2
 tNMVYZHth1DANt2tquR3KsaffvBZN+y5SsajXdSAmpISeuN7Qs4i1RCaQu2EHWggadGqDwwr55o
 wL39v9E8whPyuLx0YOebU0f++mWsuFqdeymVAECMOlAGZ5HBJyv8UrAkrp2QFh14W1jerLqVodR
 9ELSHerpgHFpcxOlyT2ldh6070jsczpgLcUOhd823G+cN54ANdcRODHnnafwg84GdAlZSp1u1TV
 9bLgRIKo3tJFiBO6F3tMtZHW9qySfwfAzBqHmPQvtl17vZoSMhPMYj+TUSinqk8jGq/CRCNTool
 xxq0ev1yRCFvEY16XTC+xfUC7t+qbaEyPcUoH66Rlg1Vkp+UIOhmBQ2ZT9IYsOqPDhYVHryA581
 /1nsrqBl+zHPb43MWh6BQXR5hsn1JrooySnrhIXxOe3TyfjuIWWcwxdzMZucK7qtss/te1NHswx
 5Uz9Fe+Eb9ITXiPWJ/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050002
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

On Mon, Mar 16, 2026 at 02:00:08PM +0530, Suraj Kandpal wrote:
> Pass drm_connector to prepare_writeback_job since
> drm_writeback_connector now resides within drm_connector.
> It also makes it uniform with params passed to other
> drm_connector_helper_funcs.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 2 +-
>  drivers/gpu/drm/drm_writeback.c                      | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 4 +---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 6 ++----
>  drivers/gpu/drm/vkms/vkms_writeback.c                | 2 +-
>  include/drm/drm_modeset_helper_vtables.h             | 2 +-
>  6 files changed, 7 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
