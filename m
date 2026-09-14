Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4514C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669410E937;
	Mon, 14 Sep 2026 00:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nc1NyrIa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KyppjHCC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68C810E937
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:23:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06dWN3348995
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l5ZzPJiPFJ/GEHid7mJTuEMsndjVp3V0ZBZ/Jv+w/xc=; b=nc1NyrIawIRS+IzH
 +tk/JTasnE3HNO+NnNmK7CUBEjhmsfi68N2GJ5fJ6ElM1TsTByVfan9eU4frPcgC
 65Rz5Wv06AEx2upIlfEuraYNHcpTeK7I2bzTYsZLsSkOjLwn3bEjyWffUg+uLyl/
 Ajl5VBPsOz+SxDumVWEzbTeafJI44JHevSe5fB5tjTtJjyw+2ab2O5dd5WRQQg/Q
 zJzNK4ZpGm/2zp4HUGeAaio7hTnlVxQqrRrL4PHNcjPVTTJ2EpgNTWQrr36feCXj
 XqyyDy/vK3A3kLGt5cjw2I2x225nsI7OaaOBm6EWs+MmyNYPEjkboz4y+DVEGcUW
 Ov6xCA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsr8n7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:23:10 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bbd01d56ecso638658e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789345390; x=1789950190;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5ZzPJiPFJ/GEHid7mJTuEMsndjVp3V0ZBZ/Jv+w/xc=;
 b=KyppjHCCDGRGvbFsR8I5UjThGnRWpTJUXY9ebs03UoFcIE9cAum2ScJFOFcz3mZ3ua
 ys+IhnEKhFAn6itCaivJR7W+YI60UWEetIx3Z50f1jWG926NXg5ASrtwsGIDggHuI42p
 VI8Me3dOVIot8wk95/S16XhvDeV5zGCeXmXii/uEV1eoANbEpUinfKt07LTjZJxuJLg4
 3/pymXKSkDIN50LYNVcnQt31Z1nfIZ6KX8ixQmd2K9tBgacFSi51NCHbz/HUI4bEEkI6
 c/QKz7zjqKmxNProfhw+fdWucnUni/fhrTucF6yft57cnME6aEmRQp9A3xlyWbTWFbnN
 8iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789345390; x=1789950190;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l5ZzPJiPFJ/GEHid7mJTuEMsndjVp3V0ZBZ/Jv+w/xc=;
 b=c+neSD5DBVtXOW/FlA7Fc4IMO41H2BWyXm+B9i6CVVGQEs7ytb3HYjX1VYE5+0IJ1N
 Y3WnnsrGQx+IlBQ+K69JAnMxkyf79IthZfw+N9CGXqtBwM2dzgsz2oswuHF8Z/MW8N+O
 2lWjaGUcK+lwBTQsUhwHo+rivvi8RDZu/vizXyO8yps531h66p2qTXkwJie3uU0Sw7l6
 JfucNGm7ugp9v+n63EF9lQfLm5BG+4OF70BbXI6GITp6b2ECByL7NNqN6/I3fVFzHs8u
 Xj3twosYA4QgF2ZS4P29RyUGbZlAGD8NdzZ5uxRFQJxQ7MwFTTrSrS3xnCCRi6g/dGCY
 bsWQ==
X-Gm-Message-State: AFuF++lHql+aev05qYMxnO0DJc0CZ9yGInr+Fk56kcH5AA2+GR1QRS+K
 d7wUYXnJRkR2kz53OyAztpxZ49ae/NYwYVjqx4NDu5cjMuX8SzJIr1Pb/Ez4VrLll6FTf5CmbNX
 fbUxjgTsZz7iQX/3BSPoz7tQ7V7DQw3LcCiQBHUuD81q6iKfrUAZD3wYVeB931PojLc3yozuzza
 KzBRg=
X-Gm-Gg: AYBFou3AWLebxrFXd7MLvAeoAAL9k2zH3RVvKaI3O+2qYNKLmnuUKVatrJzTlCSI0LX
 0Uwaz8AKcPgPlFXbVKijqaoL6NyP6xvhvzO4gDJmOPgsnBxBRpWe2uEoPk0ztvhnnbZb+HuNAVf
 +75ijarWwOZBluBFmQqijVNvjEjZTsNpwy9Pb9OAG8lGM/z4ZbHC60/6zxHIEzJxoFLmEEC7UIz
 Y5XNnqBOBf2rokQLOP5cyxpjww0No02k3mKBeyue5BoY9Fz/NdYI30i4fC5Ro6KXuoqP63XUke4
 ArNwTdtsFfngsLKaFf8GwfpFSfNCnctrvnceAAhsIGR6A+uAis0cP2almiQd7RxTPKYe8yYSJar
 lvi10iUoyJTcYVB/mtuXyg0+vq3AL0zgurwA1jXVZUZvvdnv8eSq84Q3E0NPPCAaiHELifQh2+a
 HwbgIRr2iNA8CY
X-Received: by 2002:a05:6102:50ab:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-79b56df0dfamr72110137.3.1789345389647; 
 Sun, 13 Sep 2026 17:23:09 -0700 (PDT)
X-Received: by 2002:a05:6102:50ab:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-79b56df0dfamr72103137.3.1789345389162; 
 Sun, 13 Sep 2026 17:23:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0461ee3sm2020960e87.40.2026.09.13.17.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:23:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:23:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/mdp5: drop cursor pipe for msm8x76
Message-ID: <oksemiwxoourcpn7ypa4w5rmqfa2ldes7lrwaq3rzyduy4zf6j@n5wjffpg4hma>
References: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
 <20260913233843.B7C2C1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260913233843.B7C2C1F000FF@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwMyBTYWx0ZWRfX0zmhnKwtpC3E
 tciJeZRoRFLZzyZbgeOR+bxgyfZb6t9fEMIrGx4jxZZwzQ7YfjLzBxe8hgcS0IfwhPrIpFIt8EG
 o6PWyVJ8rsURlfpBu53zYBQFZpC07j0pmWSOafvZL1GdvBvgo6PJ2454nzKK9m76BxDOTu9FK+6
 Cl1oEbtY5G45cmrOjvh6rHDQ7o/pVu5oaf57o5We08ENfQi3cJTivoF9SGOgkBYCWnK1U1ejVJa
 NUcSQWcQff0kf6voVNxJTLQVLlsk1+QB5LWjYZuL1/6kWBLNFsNuVsvTHGCWoaAACuDh3RIoVv6
 56LjoISmsUEN7WFBfvbvQWJRdodtW0l0W2hzqmVspEPpwFkui8ASaVyHgHgqQH9SfD5EBFZz9dj
 cYoNj+bEgl0oF7IcMeimjYxsN7YRY+D45mKL3g8GgmC46knW69OQpTmpsDcjUhiPvUvErejA1On
 RQYO5bw2S2MLFyRaZQg==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa73e6e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JCTdk86uwd0TV-8ovewA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=tNoRWFLymzeba-QzToBc:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: C-ny-GxbTgFy-eBwkNsrkUpUg368Tl4M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwMyBTYWx0ZWRfX3pphKdNUi9tf
 fWyONBttb8NOmIBnqf+q9/w0jsjydgSUYEOPnORfWKL4c4z35aBvcLw2Bua3TgvvOKNBmBOf27l
 KPwdDtfUtiuqFs2nkk1h5ZcfpPe0+Pg=
X-Proofpoint-ORIG-GUID: C-ny-GxbTgFy-eBwkNsrkUpUg368Tl4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140003
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

On Sun, Sep 13, 2026 at 11:38:43PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing `flush_hw_mask` update when converting to legacy LM cursor breaks cursor updates.
> --
> 
> commit e1dbf3d7b78aa6bf44fff588ff9b069eceea7f6b
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> drm/msm/mdp5: drop cursor pipe for msm8x76
> 
> This commit removes the separate cursor plane configuration for MSM8976/56
> platforms. It drops the erroneously added pipe configuration to let the LM
> block provide a legacy cursor instead.
> 
> > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > index 7c91fc1915f39..389d74ff75163 100644
> > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > @@ -698,15 +698,6 @@ static const struct mdp5_cfg_hw msm8x76_config = {
> >  			MDP_PIPE_CAP_SW_PIX_EXT	|
> >  			0,
> >  	},
> > -	.pipe_cursor = {
> > -		.count = 1,
> > -		.base = { 0x440DC },
> > -		.caps = MDP_PIPE_CAP_HFLIP	|
> > -			MDP_PIPE_CAP_VFLIP	|
> > -			MDP_PIPE_CAP_SW_PIX_EXT	|
> > -			MDP_PIPE_CAP_CURSOR	|
> > -			0,
> > -	},
> 
> [Severity: High]
> Since this drops the cursor pipe to rely on the legacy LM cursor, does the
> ctl.flush_hw_mask in msm8x76_config also need to be updated?
> 
> Currently, flush_hw_mask is set to 0xffffffff for this platform. When
> standalone cursor updates use MDP5_CTL_FLUSH_CURSOR_0, fix_sw_flush() in
> mdp5_ctl.c translates this to an LM flush for legacy cursors. However, this
> fallback is only triggered if BIT_NEEDS_SW_FIX() determines the cursor flush
> bit is excluded from the platform's flush_hw_mask.
> 
> Because the cursor bit is still included in the 0xffffffff mask, the
> software fix evaluates to false. This prevents the LM from being flushed
> and sends a hardware flush for a non-existent cursor block, which can
> cause the cursor to lag or freeze during standalone updates.
> 
> Should flush_hw_mask be updated to exclude the cursor flush bits (for
> example, 0xffffffff & ~MDP5_CTL_FLUSH_CURSOR_0)?

This should not be necessary. The legacy cursor implemented in LM
doesn't update the HW mask.

> 
> >  	.lm = {
> >  		.count = 2,
> >  		.base = { 0x44000, 0x45000 },
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com?part=1

-- 
With best wishes
Dmitry
