Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C5C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A4910EC71;
	Tue, 22 Sep 2026 11:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="otFLoj+b";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1408C10E6E7
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 11:39:31 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so23594515e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790077169; x=1790681969; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DWgqWzTsIlb5DjKPzO2i+jsPN+KX4ihkib8MZIwhD2M=;
 b=otFLoj+bnSwKXBChWBIn9eegjXaTMcnQXSe1K0rh/IElRfyzwrhqLvc+7VH4vhGNLl
 KBabHWSloo2v+huUzdtigXxAgj+jtnNkmxcN4lp7YYupRs7WNGkvYT+qkFiD6/2cgfCt
 XKfjR52TJZwVhb0CNwIb/aSUJbWVndfihU5cuVTZ5iqMKT+dz8MyviBsKI8bKAWMs7/m
 cXIbu3Kapi/Z+9ItCGzih3vrs/GiZ1BVSrq6mbP5ec9PdPlQ+RhMjbVg8lL+VGM4XIhy
 PEGhUfk0WAQmSjCW8ghHNP3ifSTKqpDZKSni98PGc1p5Vf4usntKv6mFTydvhRzMCdwD
 7/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790077169; x=1790681969;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWgqWzTsIlb5DjKPzO2i+jsPN+KX4ihkib8MZIwhD2M=;
 b=FvnQUN78R7usRrtL7pRYDB3YFEtWhAXbglmX3BrEljBKplef2YGDaRrx3LCq9f3U43
 TsfK6rlDTcD4NY1CXMJKhCU/xFSiRMc9pg9u6bFGsMTbWYntE5VHd1u2X7we5C+x+c+s
 Nyulz3V1t/3nMaTwT6q10fB7wqqZjdOQn8siD+TAPyJPJUQT8YVvZoH51tf9qa0W8sG2
 VNyuW+RSWqtsHB/fNBJ+6NhWv1e8a116nlHjQYwth1bC/86ljro94nu39Ru3E5vPfSxC
 bpNXejI0t/k1BeCo4fEzAgwVIQ3ZN/Oa2jJluZEYonJ4I4QYE9/ye5xukCXmBPv+hqQB
 ix3g==
X-Gm-Message-State: AFuF++nB//S/X4AV0cwlrEueh2M0oxabBLhtqUhv6591DugD+xhiR74x
 XiT1zmP/Ntk0eK/v3jIhkK//X05v29QLOLBCfMUkT8TySDZvJWRguFBt
X-Gm-Gg: AYBFou1pSpG6QaigJl2oJPumQu4GUTV78UNEFaUYKerMmjqYMySTCM0MCEFEcgkLTI0
 VqQoiDnWUCebd8CBywkmufPR8CPWxBbgCFsuHAWqEX3j2R0h9hWLIhTWOgOEf7+g2Bq+kiy7JE/
 FtUMQ2uTNyJmp8XPAWgmvGIb0VQHedyIx5c1B05wcFQ16OOrd3PL0L/HUmJn8JtZCTURu8KzKli
 RNjCD4MoEpY/20AZd65Lj+hEAuUH5+oPtQqh2fhAYrFdS87seDLdQihnvGnk4jNCp+O5IpdbHN7
 He2bUR1ni14UzM3/E65ztmAp/ZfSxMq9rRzZnXD05CH4YRHXtXYESTNphLYiyPllED5I0ChyaGo
 jF4RTOHesKYLjnm/X4BJq/3UBKN27uCuwZ7C0GXyJcOnr28mWRbNAlzsb8DM+21xnJbFSZASNio
 jlYwARi+REPU8jb+3hRSHlXGarVwtmz1p28T6UuUzrQ2J95aXmOzW9rIKEctVblXZEkEmpU9A1l
 0DytA==
X-Received: by 2002:a05:600c:354e:b0:49c:fc6e:a3d8 with SMTP id
 5b1f17b1804b1-49fc584f854mr187468255e9.23.1790077169138; 
 Tue, 22 Sep 2026 04:39:29 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8b97385sm74888775e9.2.2026.09.22.04.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 04:39:28 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:39:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Subject: [bug report] drm/display: hdmi: Add HDMI 2.0 scrambling management
 helpers
Message-ID: <arJo7A7L5hud3tyc@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Cristian Ciocaltea,

Commit d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling
management helpers") from Sep 1, 2026, leads to the following Smatch
complaint:

    drivers/gpu/drm/display/drm_hdmi_helper.c:663 drm_connector_hdmi_sync_scdc()
    warn: variable dereferenced before check 'connector' (see line 657)

drivers/gpu/drm/display/drm_hdmi_helper.c
   656		struct drm_connector_hdmi *hdmi = &connector->hdmi;
   657		struct drm_device *dev = connector->dev;
                                         ^^^^^^^^^^^^^^
Dereference.

   658		struct drm_connector_state *conn_state;
   659		struct drm_crtc *crtc;
   660		u8 config;
   661		int ret;
   662	
   663		if (!connector || !plugged || !ctx)
                     ^^^^^^^^^
Checked too late.

   664			return 0;
   665	

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
