Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC55CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6673110E961;
	Mon, 18 May 2026 18:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RSDROQY7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctXCEAx7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6B510E95C
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:00:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnGxR2975395
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rlz37L1Ot7SSgmPwCHZrzPnX
 arrehpmT2ZWzmBEacA4=; b=RSDROQY7e0wJOQKFunCiywPq0NTHWyff32fQHfaj
 kPeDbPW8pIEHA/FFDQ/leEA7UJPH6aapc+SP6lNzuv9NV0fsV9i67j5QRNu2YcjS
 BUOky5ZcvgOSCYiybCYPCPwO5ToMY2Q8aQ8pZIDU+ht3b25UUklN1rH399XlbpBn
 EaQOs3xTgQxjS2UGtaZELxVwdGBm/XzF54TrYUIf4DsCANmTNC47/zXzNkp3+NBS
 rFKZFmWaKoPqIXJuBltDcES6U+FFV/erapR5iWg+9Fb2feLF7QgV5MV49/DCsJS6
 AYC3pKXjxNUY6p7CDTgr6t5Zp4lOj1h2KzQRL9ZcdSpaDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48qsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:00:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso43471451cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779127229; x=1779732029;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rlz37L1Ot7SSgmPwCHZrzPnXarrehpmT2ZWzmBEacA4=;
 b=ctXCEAx7ViASO81zpdSsJMnIVhKMBd6wEICheSfkhP30arnAU1D7WgX74h96JGvJ0g
 u2CPT3cdDfymO59JtyKCRGo21Mmyvyd64wooxJ8XnBkyFf7zM9ogTJKMRNIAjvkbybyy
 jj7GjoMe99ceAT5lRFLGopZ06cBk9OS6+G+jVwyX/7Rp1B6cKaBEzyzpcz8AbHBvOLUY
 dEaNCZuNzONS4BhsV8gRn3l2J3aLXRy77ffmevNg6ljcmTLfd/v6l93skBxqx3Ujm1WW
 rFx5jFfIAv7FHVy+PNzptFCcBk3MOTXOlzSZ9fBKs4mh9M0qXVVainEMWQ8Z/21ZM0Tt
 HZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127229; x=1779732029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlz37L1Ot7SSgmPwCHZrzPnXarrehpmT2ZWzmBEacA4=;
 b=T1Bjn/FoERarSgz9a0rwQ598Zone1U2fRPYINBVMRhVpDlrlgpCeRT4MGiyOd01ian
 7VBatDhNQkB9iFy++4QC/JkjAfG7yNqCtfyWhzzByfgvuGjK5K+JKXfSrey9iAUBf+7V
 RgB4hSeAx4cF7e+SctbgVtxZKkBWeu+pvHUiedyxcxW9kH5uEQzCf6PdnMTJhibb/lTR
 MUDRBSSU0CeRYE0jgCE4IuPe7FLDQ1o6qHjA2tsj8PoR7V82M16TzsGyehWiUYYyGkR+
 53jDKz8VP2+zODWXksannlqryb0rOmm4lMijxeNtY3Z+1bRLFhm0RnYh8+qTD3Lt5uff
 CmvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9niLowTd1zX8yE8OBIBNQm243V9dN3N3UkYxqjU3g7W6w3IJPxu0pv9NJ1rD/clmLh0f8RWpfU6so=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+gcEAggIQOMsjKKs0SqXjS0FfFzi+Z9pyg8fdwNMunpHG1O/L
 JU74xWuSCLsUxsy0ey7AoisZ5StRTFXkOw5PDc6KzhDelfnHHeccr+IZGiKHGgjVa06sHxohgSp
 kdHmpjHwq+qNCPSREcyIuTqvKOAsd+5xI9lzSTlVenHkU1I0GyxGRfyZD8VmUpNFj3wEaYm8=
X-Gm-Gg: Acq92OHf+9rgV4HpZzrIy0gh7Ydob2zzVkc/w3x9cOj9TxVw2wdjn900eoTI/EU0Dmg
 QJcExbAYIc6PT8FDZZPJXjN4WXlp0CCqsl0OU1uXH4HUVvus0xOypHRu7oweIDzlMwKyz0sjkHu
 JAdmT/2QJwm+sht/GaJG7iMIgNu4HhWkSBrvcnIY9raDo31/x4B9KTubijXbZY6yY8ohYdgF8ww
 UOgRahvNgorv7NxT10rdBtKhX4aarfG9EN8aVAHV9aihXyJkToIn2XOx9VWwxoFBgDdANkSCHQb
 muCeYpOgszO/pWfey9kNd8tVXunGDk5o5do3IGfgbW5JpzbrmxRZX12njsB7OJPlEK14cVWxc6M
 ccZ4WYbZbSyLP7FB7Yyt8wJfH9Yhd+BRBsG0l83n4T0h+cPl8gqOm/g/4mu0I0yVWPweMzYQdtg
 Accnkyi984nQ0tMTXgpWnL2V2fx78utiVy1ksnAnvxLNulWw==
X-Received: by 2002:a05:622a:1ccb:b0:50d:a3a3:e612 with SMTP id
 d75a77b69052e-5165a0b5e80mr238863541cf.18.1779127228322; 
 Mon, 18 May 2026 11:00:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccb:b0:50d:a3a3:e612 with SMTP id
 d75a77b69052e-5165a0b5e80mr238861911cf.18.1779127227591; 
 Mon, 18 May 2026 11:00:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c944sm3573510e87.6.2026.05.18.11.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 11:00:26 -0700 (PDT)
Date: Mon, 18 May 2026 21:00:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] drm/mipi-dsi: add flag for sending all DSC slices
 in one packet
Message-ID: <kxbtfiizjbprs4sqkmtotbaeqmm5e3draavlmdskhmws2l6ivq@73r3hnghmmrv>
References: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v2-1-0a1b316f8250@pm.me>
 <rrgnyzpxo6g3ufjcnxnshexjotyq3riruc6wqjhirmcjo4qdta@gmwhs3mu2xld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rrgnyzpxo6g3ufjcnxnshexjotyq3riruc6wqjhirmcjo4qdta@gmwhs3mu2xld>
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b53bd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=H1zEYEgKh_2JjXxmUTcA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: kLKHYPifBC3UYIL77xE-x8TV9M8W2sQk
X-Proofpoint-GUID: kLKHYPifBC3UYIL77xE-x8TV9M8W2sQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NyBTYWx0ZWRfX6rwqVx5LOB6v
 97oB///vF+NcW7BfLhq37nPBTELiFJk7f5bPnH4KGO9gWVAYiTSd2rP7yEHd6sjpgmFVNhV3np2
 kjSb7FYL7C0qyojxrPPgb79rywZV+S8uHS8kdhPUFzi4RBMU/UBd41X3ROxISqgEzZ5xBgHf/wK
 FA4OwDo7TUYZIr5VnaNRmJ4H9HXTaianz7AGomfbiY5bwIQX11MTSVjner4trIK7Kkiu5ZYzi7J
 KGxadTXJhLP6GqdB92fZ6YBPgPirM2tbEzl8G0YR1tENah8ZurXbeB2I/xpWXYQ2pDRU59cMtM1
 8wDDu26f+vR4YsAFYq+mE/gGrfIApkWmnGoAEBkOQZuv5e5PzggyWPIwD5B/3cFxnDDNAYt53FE
 FKvFe3W0hXzFtG2VFIZwIhH7r7RpOZSqrpRjfIN4EhP1rU2QlmcVIAlEq/uZYWOr6A7sKxNK53d
 Rk/gYwwkspMJZlVsFyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180177
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

On Wed, Mar 18, 2026 at 12:33:45PM +0200, Dmitry Baryshkov wrote:
> On Wed, Mar 18, 2026 at 09:54:04AM +0000, Alexander Koskovich wrote:
> > The MIPI DSI v1.3 spec defines two modes for transporting compressed
> > pixel data: one slice per packet or multiple slice widths in a single
> > packet (Section 8.8.24 Figure 40).
> > 
> > Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
> > set to indicate that all DSC slices for a line should be packed into a
> > single packet. When unset should default to 1 slice per packet.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> As I wrote for v1, I'd prefer to get more opinions before applying

Any comments? I'll apply it in a few days otherwise.

> 
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  include/drm/drm_mipi_dsi.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry
