Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFB606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UtV4N8Yh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09C310E653;
	Sun, 22 Nov 2026 17:14:37 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFBF10E4C0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:31:45 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b413f6dda6so267225a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 01:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795339905; x=1795944705; darn=lists.freedesktop.org;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R5GY9TTuofYTaa/ZejIza37Mpjz95YygMJZxjVzg2k8=;
 b=UtV4N8YhcJaBzI0rvhzxotxchzbWYuAdk8IKchbV+nz5pEXwLYPWLYiG3N6i9MialK
 +IuFhsdHWlzQUmb+LYaz1HFnIDmY55UymmQS3WbF+O/vNtoenqT0b6b+Jl324zOA87uy
 ag3lfrFY9KRtqHaVYfanRZpJODqa1266+SCKdEbygUEfss35XQIyHN786cCGPg/7GF6K
 Yd5dDuaqP5ykxjUmZu1Bljs+s7IShhr8TZfNpIxi/fuYztjXY1qW7r+pIT1S+H00bWYC
 spvdSws5a20x3jfm4kdoPEmQRmHrVOZeV77qaaV9G4gxES/rTmYix0TFCjgqTAquNdU+
 wQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795339905; x=1795944705;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R5GY9TTuofYTaa/ZejIza37Mpjz95YygMJZxjVzg2k8=;
 b=2k7vKjftvXagXLOfB84Ud3ap2XTcEbyascyUeVrcIrhdwrTNyWSrqs862z86M6yKSe
 KhQTOrCNULWvlWgAQnlABmmqYaRpBrqTgevXbDIcPzXp35DE+FWyAnkbmaPfsJUYlXfN
 oF5ce4NAVCqqe8+DOJbgr1RqYwxlTeWhWiqXpI3nB1wcl0MaTwQ6NAeL9ZbpgUNjtQtj
 XgU2bxmsxlTy+loFuyWln0TeCRxnLMzdMktp3hPekZ2hIOrYE1fLyrDO1z1xqKhcTrQM
 2AwtPy9trvLqMIwvnDX98GL3F02hgSok4Xi3AO4yTEXESdDnq3rpeFeUSSTG41KU6kDK
 h+dw==
X-Forwarded-Encrypted: i=1;
 AL+hErG2FhL5xrscnRFScbCBscLXo1ITG+sRBhP6EuJAUphOvKJDCQMMpBfyPkDMd/TtvEVGIcTbi/U7jA4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+qYi5vbqPC+lcPnpDxDKJKpNYvfDIUajXMVaCBinH65sOA0g0V
 McFmN4M4WV7n0U1+D87Pfjh3s+QbDgMoSJhbO1/oEEvjRgKhss9Ygt8/
X-Gm-Gg: AZFdTZeEp2vXq0Byx406iZMMDl8wKadH3JjABzb6pE5qRGD+KBlKuRBNlaeTK26ATN1
 65m41s5vZ2QFckjpfzedseNj8anMBQUpUq/8O76GETG/NImNvwOALwvWpSjAjaFCI3Fl19x+XjZ
 NQsGYfQ8JyIUxOOmuluGEtTp5qDmYWOVfK025hSnN86weRMo8VfG1BuYrkdp+BwQHk5jgA+az8o
 rcmO32ytsW1fy4vNA5wAkvwveb580o7rgzsN2iSbdMh0JiDYNjZyIEi9Ol1XvOeqhmNDlHXVPXG
 TDcv0rRZjda+1+vah6ylCDf01Lz0BS0n745Ycmopb37RWUXmvYRpg9oOKc4TSO6Ys5KkhPICdXT
 UUkqhMk7kUlmC0dgFSm5gaUIojlvWBwYAkgI2cpLnroLmEkh3fS+UtryC3ev7RPtgVjuGeamU1B
 mCx8VZxRASAbs6RcP/rVlBZf8C/GqCIsYv+yYoUpcHk5670TA4FzfGodsQUqIjkiTxc5M1Vn+6J
 f2M/PyY6iY6JtFDu0hSdINFETjiZHWoqHo4FsP8jOuUYPFJEh3gs3ZDiiuGUzKhZy20kc/Lo/5t
 sDg24jYeTLbrYlvj2lfw9ScqZ82qizKOfyLZLb8pu25nxhjeGtyVPJ2GutYmE40CnBGg5Ak0RL4
 6zjU8oNeEsxd7gpgBOcq/h5mnM7g=
X-Received: by 2002:a17:90a:e705:b0:3ac:9c37:9422 with SMTP id
 98e67ed59e1d1-3b41c7e4cf5mr11892464a91.2.1795339905049; 
 Sun, 22 Nov 2026 01:31:45 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm14795295a91.17.2026.11.22.01.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:31:44 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Andy Yan <andyshrk@163.com>,
 Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Alexey Charkov <alchark@flipper.net>, 
 Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v12 06/23] drm/bridge: synopsys: dw-dp: Fix AUX transfer
 timeout race condition
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun, 22 Nov 2026 09:31:43 -0000
Message-ID: <179533990370.107225.5765165679182115805@gmail.com>
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 06:00:39AM +0100, Sebastian Reichel wrote:
> @@ -1491,6 +1493,12 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
>  	status = wait_for_completion_timeout(&dp->complete, timeout);
>  	if (!status) {
>  		dev_err(dp->dev, "timeout waiting for AUX reply\n");

This still drops a reply the sink did send when the IRQ thread runs
more than 10 ms late. On RK3588 (7.3, KASAN on, v11 of this series:
same 06/23), with a SCHED_FIFO hog at the IRQ thread's priority on its
CPU (busy 40 ms of every 200 ms), 1410 DPCD reads gave 183 timeouts.
Checking for the reply once more before giving up gave 0 timeouts,
with 127 late replies taken:

--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1493,2 +1493,6 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	status = wait_for_completion_timeout(&dp->complete, timeout);
+	if (!status) {
+		synchronize_irq(dp->irq);
+		status = try_wait_for_completion(&dp->complete);
+	}
 	if (!status) {

Feel free to fold it in.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Claude (Anthropic) wrote this change; I reviewed and tested it.
