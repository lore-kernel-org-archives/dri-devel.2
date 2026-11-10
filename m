Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE929606E466
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeGhYaL4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09D410F6C9;
	Tue, 10 Nov 2026 13:15:39 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B04610F6C9
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:15:33 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b6f42095bcso2658981a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316532; x=1794921332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JWzAuUod3dRgtMpvML4dHGtO+fvxYrtKFqQrNT4osTU=;
 b=EeGhYaL4y5sOwhHG9OwZKW84FxKDCqXB11jRUmyhnKpKzilYQ5xWGKW1cQ7+Os1rCz
 qgFuH1mSIwi5WmS/JN70+oXTHiK0ZRLvhLofzJa47VKARTD2ppKnaSVNQFZHJVrIT+7+
 nyCrIMYbqp2GaSWlnqaKiw+z5UuLfuZoMgw22mM2l1ZaPCMcS9lgTWMUAIaaIZk0I1wv
 xI2CJulP5Z4ccUmk4adNhRcWDl7SCwJrjKsi7mCYqdfpUkZWkoUsRnwlMDa92vahx0jc
 jTMIys2OybT2kzLRYPAR7H1iwNexoQJyMCKkSzJCM7V/FZ330n3WLa4ymtvCViGuHJvC
 dcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316532; x=1794921332;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JWzAuUod3dRgtMpvML4dHGtO+fvxYrtKFqQrNT4osTU=;
 b=EqDQ60HzwhTxjvoT7PqXlq0A+0eMtHYH86+w5whmgTIP+01ii36Tp+8BAnwWRoq0jH
 SpxGAYNl7NEORs5+dyz6AjsAc1Sgp4Eyb+2IH4vUzcqKWmshUgH6euyLhKEXUvX+85hA
 B1H2L9EwlIYD7QGKWIvW/OAADWSpi6ntleEumEJK0GPh7fOliA2jz6xddlcVlVreu32b
 2BkY55aiGHa8TNQhBfx8vTZYKbIlXM6IysHYfB7BVR6IIE5q0CNR97lBJ4OCZMkbceOb
 UwVESM/wDtyJJ16B++MlD5hZXy/r4Jbup4GJPG9cJTdmAPO/VoqYFuvRDNf7NIZ0Esnb
 GS7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHSbh+UDLWsJOThlAHzWOzCr3jeOdbPA/o5hlhvPXwfn5AWMW/riTNs0CIOlPjoOWC+c2j8LZID3u8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8tXPyoQL0NX0CmfUpx/02U8HbII3CqolrMOya1GKeU6K3oPVI4
 OtZUGWDuWsrsD667qSh6AqK+UQsffsyqgyRY1WBEYP6YZwzOTDIhBTMq
X-Gm-Gg: AYBFou1ZKXBQoxn3SmleCSVpqfQVJGWrsDCm7cPiS0VyVa3/zYhkk2HJzlt1+lNGjuw
 LDWc2Z1E+H7k6nprvSJXzB2BFqh8T/uLZlKeriqUZnwI9P7Q8U++hWPky4ajltXwm0HqT6uk9EI
 TFg2vjPAoPBR0o01NBFudwroW3GWs2EI9BRYCXQza+OBg/9j5DstizJkqGhDTUF1osFrLwBIank
 v1DCrytcCkICjCCJFWv913wKl6J9NLE2pzrczwI2wFID+hSJosV4uxpOpLVpqLUJX11vOe6+63l
 7J3Uk4FxUxD6M0E4KeUrw3fylUtfppZC1Vil1sIV/d8zy4e7UI1VQ4tz2THdVA06FAG2YhiDBn6
 afEXG9/3wSqu3dUdAlIYZ6Oa3rEMpVtq07kD3PnJzqM0tmsUUcvWwkjzVYd4iNeuwhHF2oZ/rGW
 T+6ejbvavqJ8DeM37ZD8AVSVb6qHCvL2ExZnJaUoymFJCDtQsHidDlbbXQvmyZ2dwIM0PYczXge
 yA1uFCZwODl/FUdnRSalp2iWqcBm+bYudlBbyk3I6zOjgZijwrPtRnV/YE1iaclNC+vAxv8hC3Z
 /3cxBm97Nw6E6eDrBM5Fj/WyMyQaA7n5v8WbdkjwspUal+MFwda4hy87g5ZSMU16+kdPdg0kNJs
 =
X-Received: by 2002:a05:6402:90d:b0:6b6:e8cb:642a with SMTP id
 4fb4d7f45d1cf-6b7564dd74fmr1981433a12.17.1794316531608; 
 Tue, 10 Nov 2026 05:15:31 -0800 (PST)
Received: from desktop.home ([46.205.207.69]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75790353asm1126372a12.31.2026.11.10.05.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:15:30 -0800 (PST)
From: =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>,
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Andrzej=20Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Subject: [PATCH 0/3] drm/amd/display: HDMI FRL training fixes for slow sinks
Date: Tue, 10 Nov 2026 14:09:53 +0100
Message-ID: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With FRL on by default since commit 5fd3b60d9b80 ("drm/amd/display:
Enable HDMI FRL by default"), an RX 9070 XT mostly trains a Samsung
QE65Q80T (2020) at 6 Gbps x 3, where 4K 120 Hz needs DSC. Windows on
the same machine trains it at 10 Gbps x 4.

The TV needs one TxFFE step at 10 Gbps x 4, but requested levels never
reach the PHY; with patch 1, the driver programs them right away. The
TV sometimes answers an LTP request only after up to 967 ms, while the
driver waits only 220 ms in LTS:3; patch 2 raises the limit to 1 s.
After waking up, the TV can stay silent at 10 Gbps x 4 for up to about
four seconds, but link verification gives up on that rate after one
attempt; with patch 3, verification tries the same rate again first, as
the enable path does.

Tested on 7.3 with an equivalent backport. Without the series, 4 of 6
boots and TV wake-ups ended at 6 Gbps x 3. With patches 1 and 2, 16 of
20 reached 10 Gbps x 4, and the other 4 are the case patch 3 handles.
With all three, all 63 boots and TV wake-ups over 12 days reached
10 Gbps x 4. In 13 of them the sink stayed silent at first during link
verification and answered after one to three more attempts at the same
rate. On amd-staging-drm-next the series is build-tested only.

Andrzej Piątyszek (3):
  drm/amd/display: Apply requested TxFFE level right away in FRL
    training
  drm/amd/display: Wait up to 1 s for slow sinks in FRL link training
  drm/amd/display: Retry the same FRL rate after a sink timeout

 .../display/dc/link/protocols/link_hdmi_frl.c | 56 +++++++++++--------
 1 file changed, 33 insertions(+), 23 deletions(-)


base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
-- 
2.56.0

