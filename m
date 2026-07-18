Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B64FC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC7310E5DC;
	Sat, 18 Jul 2026 18:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGNZsNoC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXnQl07v";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4463510E5DC
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:22:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGOLgY1002807
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HyBbYwp5p4Yke6LTJxxI12Zk78NEYeUMQXe2QXNyi9Q=; b=fGNZsNoCnta2l9tI
 FEPN5AaesMZTVVdySsoa1jZrc6/5uojsZCld5WXLUhoAFfZNfxYWG7j8782rW7z6
 ArsngHIB07mOYl/Rpum6JWK/cL2duwOcfyiYNdny1Qye9Zr+F8I7v937NIpg0TTo
 7AhIkc2WgM68oMlSqqRrS3V7p9uh5LpnN1V7wTkOj4TCpQlT8PxeN0dXvYdXvHtl
 xO3JnFQz5rbRTnRhnJnJOPv1rX+l/P0qy0iXLlB9CkVsM8D2KqkrvaDSViJlhC9h
 qTyltTZNzIcarxtvEQKLAZOZgrloCuyZkpnt70irZj7lS/dnLiUCqUulhmui6nEn
 abiKew==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chhaqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:22:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so6010790a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784398929; x=1785003729;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HyBbYwp5p4Yke6LTJxxI12Zk78NEYeUMQXe2QXNyi9Q=;
 b=WXnQl07vYpYpkpldfK4j9l5oPyxVXfrD2GY++MqzIx7b+s9hVtkqCJSpSceXJjp5pZ
 szQNcOpIxSGnWz2z+9QMKDR4QAn9AOqmpyI2bXPj5/7AhMz36FKZRGzJOetYh8FY12s/
 ErPTXpa/bPg7r3A3Bv9a48338KBAUQwl2WpKZLYhCE7okp1geJOSC9F89QwfzOJjI0RO
 JkIIxKODxhAMlC9Yzdgr+JhO+iW8ddZ07gVshyqjRz4Y/7Y2rKSDUZo+p2dlm+e2l53J
 w5gv01Ij8FRDINoL2Wksm4jW8Yt3iwv0VCQ84Mp9SGp6scfNlBZCaJuGMtgf+T7ThRdb
 xLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784398929; x=1785003729;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HyBbYwp5p4Yke6LTJxxI12Zk78NEYeUMQXe2QXNyi9Q=;
 b=ZjRKLwmx5KXU1UsC91UBx1I4ZYRwtSA8eRVW/Y+oZ2zp7/z0YWtk/AT7CvvxbFdMn6
 O21kMohyE8egxP1z8cI+5LTqKi94M9h+3/M/gXFgaJPXW248OsE3NJJHgKQBXJ0c+VIU
 AwB2BNxuGQDkpFOVKmU+iFRaBA+LLD6FSOJ9q6dGunHuBm0at5gm9o03zkgS+VVHOnyd
 hryA7W4PZ4m4HGk+wuF4gAVJ7oZ49wy810GQdjwlKtKWMYqO/XPim5XKsqzJa2rrq52Q
 XrnjddVAmmPTc4jj0ogsq3WjtlaSqNgEYqv+nZkqO66Abvq9EXSbo9i6gJprGoxhZ2Zz
 odkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJSkJxa5E07QoinipvX9Ipkpqio7axFUg9JT18RH9atKN4Zep1LxmEaCkE7IKlk+AQyA7EUGmOv3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBdKlYnY8ScL6hVa+PEnwoFu/YDZlJ2z3qrhNRagd6/atgUo2y
 EHOxHqACyhiU6R4WmrsigFBpNJ7K/TTTQjpeERKXU69jM07QSHRvrwG4eDMgf1a+kOXNLrackoS
 vjhBUY3llg+K11jkIaZZ8gf93tbCBVQ3eZWzUEWdePJ68uLwsXekDBDVkd0ZBCPO0g9w1eLQ=
X-Gm-Gg: AfdE7ckiIkNE6J8GErzrQGhPAvpX3lX5yQM5WjBh7Cz76ga27vgifCOYODW9KAcrdB7
 iB9qXafsuDWaLyxP3l0sTxQKZR1SUhlon5WBmH1RFQdF/mn3SHCiEa3oNTL0B89RtV0tagWQ0k3
 6YTZG4K/MeUKlc8RzZTV9p6FlfyuOOtJX0LZaG59EHZs08bAn5Mmlb3pfeu5oSFK4pSdH1qqVXr
 Wcni2Fuzad+J0oY6vHwiuZKEIgsC98r8/AHs00onAIdUcbhnaft64ypmx2V7Ex1KY1JF8qZzBW8
 Xmjh8bYvO6WeRfqD7j6xBuWnvFG/oXxa0mrOxLlzWCNvJLLSOokHJ+G2uyQ7GAzkUuG5+VHVEXN
 btyF/KQ==
X-Received: by 2002:a17:90a:d605:b0:37f:9ce3:ca95 with SMTP id
 98e67ed59e1d1-38e4b54436bmr8084706a91.30.1784398928609; 
 Sat, 18 Jul 2026 11:22:08 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:37f:9ce3:ca95 with SMTP id
 98e67ed59e1d1-38e4b54436bmr8084675a91.30.1784398928065; 
 Sat, 18 Jul 2026 11:22:08 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2de31a7sm16705718c88.15.2026.07.18.11.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 11:22:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 02:22:03 +0800
Message-Id: <DK1WMKS5DBMB.3O0SCPNN6ZSVV@oss.qualcomm.com>
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: <imx@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 7/8] drm/tve200: replace struct
 drm_simple_display_pipe with regular atomic helpers
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-7-1133a8fc3785@oss.qualcomm.com>
 <20260716092549.D4B5A1F000E9@smtp.kernel.org>
In-Reply-To: <20260716092549.D4B5A1F000E9@smtp.kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE5MiBTYWx0ZWRfXyjEzhvymnVc2
 unqKtJDu8EffIank8G1XIgKxAvNlSNHfS+3Duvp89Kwks96SjZcrBGTmGbrf1BupfTkpcrmRrxb
 YufR86Ki67xAmq7hFXnwn1QTEhPcfJo=
X-Proofpoint-GUID: fHUfQKEsZFLHdCw9EcLsiDUOQHds76Y4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE5MiBTYWx0ZWRfX3UNH9XCzVTyS
 S9ksw0cxlLofrhvdpakd+qPSDO3tx873Lr2VNsp81kjw6W4Ugyn+3MLsYM3N+RwUVd8wdjRoPI5
 egaYfL2zlxNWnJjnrRlKzWhe0De+L6whXPW1PPR3YB+EkBW6bq9jrXb1ixF5LN037RQPr7OLvus
 lVL9W/S+uRNsG7Wqzw4ZtLUyGd06BGFqOCNpxbiHPnFGSmTbLdA27DMoDy90Lr+kUK0Hkynn4d6
 I2CaTGkBhZ8G6TQ9OsFrrSfv7MQ/aN7YsSywTWSeUPAYc/imDQ4bHGNE9dR3Q2mKjNGnELOUfPi
 zE/47I1NHwe/e0ae2GBGezp+tC927VhC7OqtNwZKq82qS0kIO8Uyhx+E1xIcNim3Y1VHoSqS1il
 3fZ4b/AyGMkBj86jc2TAsPHJViWieg31UVe/2yL07KuB4dRoZ92hcAA0jfzRbEPJC5NWDleH7/n
 0FwgJTr/UpCKskGOQZQ==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5bc451 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=kdYVNXHMfqCZok_UY-oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: fHUfQKEsZFLHdCw9EcLsiDUOQHds76Y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180192
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

On Thu Jul 16, 2026 at 5:25 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Directly accessing `priv->plane.state` in the CRTC atomic enable=
 callback introduces a Time-of-Check to Time-of-Use (TOCTOU) race condition=
 with subsequent non-blocking commits.
> - [High] Missing `.cleanup_fb` callback in `tve200_plane_helper_funcs` le=
ads to memory and resource leaks of pinned GEM objects and DMA-buf mappings=
.
>
> Pre-existing issues:
> - [High] The CRTC atomic enable and disable callbacks call functions that=
 can sleep (`clk_prepare_enable`, `usleep_range`), violating DRM atomic con=
text guidelines.
> --
>
> --- Patch [7]: [PATCH v2 7/8] drm/tve200: replace struct drm_simple_displ=
ay_pipe with regular atomic helpers ---
> commit 30e007b0736d27ee72ba4a5f39e203c3808e470e
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
> drm/tve200: replace struct drm_simple_display_pipe with regular atomic he=
lpers
>
> Convert TVE200 to explicit plane, CRTC and encoder objects. Keep generic
> plane-state validation before TVE200-specific mode, alignment, pitch and
> format-change checks, and install GEM framebuffer prepare helper explicit=
ly.
>
>> diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/t=
ve200/tve200_display.c
>> --- a/drivers/gpu/drm/tve200/tve200_display.c
>> +++ b/drivers/gpu/drm/tve200/tve200_display.c
> [ ... ]
>> @@ -119,16 +140,72 @@ static int tve200_display_check(struct drm_simple_=
display_pipe *pipe,
> [ ... ]
>> +static const struct drm_plane_helper_funcs tve200_plane_helper_funcs =
=3D {
>> +	.prepare_fb	=3D drm_gem_plane_helper_prepare_fb,
>> +	.atomic_check	=3D tve200_plane_helper_atomic_check,
>> +	.atomic_update	=3D tve200_plane_helper_atomic_update,
>> +};
>
> [Severity: High]
> Since .prepare_fb is assigned to drm_gem_plane_helper_prepare_fb, will th=
e
> lack of a corresponding .cleanup_fb callback lead to memory and resource
> leaks of pinned GEM objects and DMA-buf mappings when the framebuffer is
> swapped out?

The documentation for drm_gem_plane_helper_prepare_fb() [1] explicitly says
that simple GEM framebuffer drivers do not need a matching cleanup_fb hook.

[1] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_gem_=
atomic_helper.c#L107

>
> [ ... ]
>> -static void tve200_display_enable(struct drm_simple_display_pipe *pipe,
>> -				 struct drm_crtc_state *cstate,
>> -				 struct drm_plane_state *plane_state)
>> +static void tve200_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					     struct drm_atomic_commit *commit)
>>  {
>> -	struct drm_crtc *crtc =3D &pipe->crtc;
>> -	struct drm_plane *plane =3D &pipe->plane;
>>  	struct drm_device *drm =3D crtc->dev;
>>  	struct tve200_drm_dev_private *priv =3D drm->dev_private;
>> +	struct drm_crtc_state *cstate =3D drm_atomic_get_new_crtc_state(commit=
, crtc);
>>  	const struct drm_display_mode *mode =3D &cstate->mode;
>> -	struct drm_framebuffer *fb =3D plane->state->fb;
>> +	struct drm_plane_state *plane_state =3D priv->plane.state;
>> +	struct drm_framebuffer *fb =3D plane_state->fb;
>
> [Severity: High]
> Could this direct access to priv->plane.state introduce a race condition
> with subsequent non-blocking commits? A fast sequence of commits might sw=
ap
> the global state before a previous commit's worker executes this function=
.
>
> Would it be safer to extract the current commit's plane state using
> drm_atomic_get_new_plane_state(commit, &priv->plane) instead to guarantee
> it reads the correct snapshot?

Will do

>
> [Severity: High]
> This is a pre-existing issue, but does tve200_crtc_helper_atomic_enable()
> call sleeping functions in an atomic context?
>
> Looking further down in this function, it calls clk_prepare_enable() and
> usleep_range(). Similarly, tve200_crtc_helper_atomic_disable() calls
> clk_disable_unprepare(). Since atomic commit callbacks can run in an
> atomic context where sleeping is forbidden, could this cause system
> instability or deadlocks?

It is a false positive.
