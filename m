Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE49BC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB66B10E227;
	Wed,  9 Sep 2026 19:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1vAYdNT";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA5710E57F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:41:41 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499db1740f2so2669115e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788982900; x=1789587700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMV0mMGaUxuAC5co0uH2uhYqExWWNSi7vJ8S06jVFgM=;
 b=W1vAYdNT03QcmCM0abY/2+j1pBXDbIWA6QNYGRlKzJfUAowxews0Bquh0vcmZH52V3
 YnPhZv131AVNiXi9HES5P/jFlvHXeW6qhR7MqxfggWKN3iNflTPpfnvwQHZ6v+Z8k67w
 CXOfrcVUlSmublkVBYsTAuQjw8gs3cACKmUlEWfFDI0s+2ZSInYbgFyATnUJnFe1U/Cc
 2wufGZ6hBBhlOUByF0tVsZF/I3AfDr87nB7OmDKgRV8EywuxCw2Ql+Bpha+0QViSSBUD
 XoQByjh19CxDw9Tu7KsLV+QQ+iyBzQDE8BzBrnoGlGQb4Ha7ROHY2fxKXq2PJQ0RXwHZ
 vVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788982900; x=1789587700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMV0mMGaUxuAC5co0uH2uhYqExWWNSi7vJ8S06jVFgM=;
 b=Wd1IEUcCbZ8KNramLbpO9RurGy1M+aoY4N515RmiR1VJPzOR28OaKOarlt8wgdqAhN
 Dyh5RYO9mpzIjbV2oeEVKam2EVTVlsS0jJXpDchsaiXgn5N7ujBAI0yxcc8ez2pPsAQ/
 gWj+9BLjgjujavu/eYKIiOBsdCbNBA730AlGi0ZZtHXDTtEUPcc0lVs2ksc9Wp/47FlN
 kYCdfNV7ZM1bMaO1PLTQ3qUH6Eb0P4/g8Ercu4KsObNJ5L65NR2fbXNTKPg6TsTa3TjB
 GnwRmR92bLF7CDx31rqapZdJ6NFYVZxToMaolFM5dH8DLjrC1QOxnCcLpiH+bmHI0ye2
 tS8w==
X-Gm-Message-State: AFuF++nhFdW68Fs4VRLSwxpxcDH9zs+eeR7Q8Dj6AwKnxDui+v3Ha82O
 QssGcCLCA0dzg8cRuIJWdivBAQlygn+aaELnv9cVQYy9nrb/f49lZQN6tTXgZw==
X-Gm-Gg: AYBFou1Caf6YuW6SUtKOvL2OMgULkkFpqgNuIp/hGVhE9KiAG/YYlEOn3w3bCLr8/Wn
 rBgyOKVUH91dxtbwPL6XC+hSUsK4nR6JZqKoaJOPrR1GdKsaPI/B3ibSQo27mXsCBMX4tkB2p6M
 kdiJBWs59o9lbWEpAhKZhnoqhkjnpRVi7sOUuylb8ESTI6sofivf1SmMgorxBQcGTSVPM9jjL8+
 2GcI4XncxbX2ZYVT5/6LIbfyNsKMdXAHVmkSy1vC+AyqFdJ+tq6DlIpHKNWcACdSsw+s2afR3Xv
 bHeotmV90Ah2DEcluoozoiMsW1Zdd0/VaEFO6rpvxqznKi7fYDqgZhE/9+0LBVOjU6qYnPrTXDl
 P+NhFYl3OS+DuKPqRgJtjgVqqxPaoWAuuDkN4S820vHCxmzqMJO9KDFwmhbnRwg4uADy+2DeBSC
 Y/Vf2Imzt4negFHRElTIrPRAJ+iJMRWmTz7h3guNdDImp4+FgpGhnqbmijftz7tkcTeaIjWta1f
 TrR6L74rWylgU5Gf0+XScm6qRhCaLbvrYiwqXTH+tAEQ1YAEaEJp3jw8EtkUUgGDu049SVJX/G1
 d0mu
X-Received: by 2002:a05:600c:474a:b0:49c:ff81:e062 with SMTP id
 5b1f17b1804b1-49d276628c8mr3990025e9.2.1788982899647; 
 Wed, 09 Sep 2026 12:41:39 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900C06E5685D4591C35.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:c06e:5685:d459:1c35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fce7a7sm167161505e9.4.2026.09.09.12.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 12:41:38 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 3/3] drm/rockchip: dw_dp: Attach "max bpc" connector
 property
Date: Wed,  9 Sep 2026 21:40:35 +0200
Message-ID: <20260909194036.8889-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909173542.14030-4-royalnet026@gmail.com>
References: <20260909173542.14030-4-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The bot is right, and it is worse than it reported. I went and read the
code rather than taking either its word or my own.

drm_bridge_connector_init() has two paths. With an HDMI bridge in the
chain it calls drmm_connector_hdmi_init() (drm_bridge_connector.c:1016);
otherwise drmm_connector_init() (:1027). And drmm_connector_hdmi_init()
already contains, at drm_connector.c:621-631, the exact block this patch
adds - same shape, same comment, because that is where I took it from -
and then calls drm_connector_attach_max_bpc_property() itself at :633.

So on a chain with an HDMI bridge my patch does two wrong things, not
one:

 - it overwrites a connector->state that has just been allocated, which
   is the leak the bot found;

 - it calls drm_connector_attach_max_bpc_property() a second time. That
   one is not a leak: the helper reuses connector->max_bpc_property when
   it already exists, so my 6..10 range is silently discarded and the
   8..max_bpc property created by the HDMI path stays. It does re-attach
   the same property to the object and overwrite state->max_bpc.

On the boards I care about there is no HDMI bridge behind dw-dp, so
neither fires today - but "does not fire on my board" is not a reason to
leave it.

For v3 both blocks get guarded on what is already there:

	if (!connector->state) {
		... create the state ...
	}

	if (!connector->max_bpc_property) {
		ret = drm_connector_attach_max_bpc_property(connector, 6, 10);
		...
	}

That leaves a question I would rather ask than paper over. The state
creation exists only in drmm_connector_hdmi_init(), while
drm_bridge_connector_init() leaves the plain path without a state - so
any bridge driver that wants a connector property at bind time has to
copy that block, as I did. Would it be better to move it into
drm_bridge_connector_init() so both paths get a state, and have drivers
just attach their properties? I am happy to write that instead, but it
touches shared code and I would rather be told than guess.

On the pre-existing [High]: the bot is right that the error path I add
inherits it. dw_dp_bind() takes devm resources on the component device,
including a non-shared devm_request_threaded_irq(), so a failed bind
leaves them held and the retry gets -EBUSY. My dw_dp_unbind() call does
not release devres. With the guards above the new path becomes hard to
reach, but it does not stop being wrong, and I did not introduce it.
I can send a separate patch moving those to the master device if the
maintainers want it - it is a different change from this one.

Igor
