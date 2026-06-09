Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12022CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B0910E03D;
	Tue,  9 Jun 2026 21:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0Rupf3L";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC0610E03D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 21:39:53 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5aa624ff3cbso6136102e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781041191; x=1781645991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYi+y3RHUNy99bp0WePzJLFwY9Ij6avtyt2hv2NOpcs=;
 b=E0Rupf3LyIlM3cvy6PvefMw84A7BRdRAu7432lnPCTYT8MOzCZNrQtGA0T32BvsHSu
 Sbrx0YSTuThB94UY/+LtLQJx/9euEUdCEDrhzEvWIsE7QskhUpLaHrnE2b3S7UF99lVD
 us0UP/plM3+comvQ+VoiVE2nN1hWB70cpBF3eorzHkfJlNtiRzZ/PymF/ES73KuArNzR
 iR5UA+jcI7D5u1iG2peaW5FVQkqDb6o473i6gQtec47wOMo2VJn3NQ0bb68gpjFu1hpH
 4PQut9D7AyiNpuvgemgM0yxlth67xtOutw1PPP2IXQEUizZDRg20yDAn5yVDBS6xaKsz
 dyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041191; x=1781645991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYi+y3RHUNy99bp0WePzJLFwY9Ij6avtyt2hv2NOpcs=;
 b=R70qX88MTtp+frsbFW1+QFMChNgRERwFuNRzNboT52iNu0HfcrEcNHCWRRk09+X/NU
 nVTaje796jqR+5VrJqmukvZ0wWO792MI9itvus+ZFIcvGOAbUfBcOwilbBfo/wYPDnjG
 4E/63VQMlqmGmrZLsFFozxnfo8enhc0uPankYCGuciBGoV8INgyf+7cRnm/4o2T0zx9z
 /LMMGvkAGQZpIdiHXQhCUvIZFdSmCL17Kr2l10T7dxMGNHhaYBTzfY50hf6t7UQ1kvOC
 hDXY214VmiFCmpdI5Kd+zIz5dkH/4HtX+p5kJWCl9X7l28JbAiNWRW/G2kH7IdzaY2fq
 NPOA==
X-Gm-Message-State: AOJu0YxrGwyg5CJZ44bJ5Hm4FFduf7sxpevNT6fwjQc8SpBTcUodmhxr
 a3xGv8DekTmE1f4leTmFUszpG2YLJuZE6mqw6lB5RrgASumdhrfco7Qe
X-Gm-Gg: Acq92OF7ysq00Yc6qvbiNCcWypUwHl4TumkHW4VWQTj9mJ1T/3TLyjfIVNOmnKfbAaB
 xWJnB81mEtytOos+/tGd63ew1gDl5lfYzY7PzrCD7xHFtvRu/aWLqcvwLpFQ+PBHoGJcjgEp8EP
 oXo+weVGhJlTXi3FXQvfuRCzCL5wt9yGJ+60dJEcUB6Ieo0pcjNMbwbbA3BZ1FuPA9l+BwDE165
 JUfHVRCzAYRMDqaPEuv+ejvZLyTJZS17WCR6o+7dI11jO34TyeRkgmyQDdVUXGpPGfQcLcQBBO7
 HRbQZ70+AsHGCFh0KythkOxp/LLktmY78Ldiiv8hiK1Ffvg5fzL34gK0MPFWOrbA3XyeUyyoIOx
 DeDjuA/smWFCiWJ719KtSPUVuH96U6klGaii05GquEcuBjCSWU8lFpAnaeYPbH6Nw2k6ZPUNp5D
 umKThXPfirWWTwkRiMcUmc2e6FLZCmVbbyDMg+uHh728uqwMvi
X-Received: by 2002:a05:6512:1387:b0:5aa:b6b:796e with SMTP id
 2adb3069b0e04-5aa87c223ecmr5678114e87.42.1781041190998; 
 Tue, 09 Jun 2026 14:39:50 -0700 (PDT)
Received: from localhost.localdomain ([193.27.19.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b98fddasm4815684e87.64.2026.06.09.14.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:39:50 -0700 (PDT)
From: Daniil Ryabov <daniilryabov4@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC] drm/panel: simple: panel_dpi bits per clock
Date: Wed, 10 Jun 2026 00:38:51 +0300
Message-ID: <20260609213853.794538-1-daniilryabov4@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hello,

static int panel_dpi_probe(struct device *dev, struct panel_simple *panel)
inits struct panel_desc for panel_dpi, but it leaves panel_desc.bpc uninitialized, maybe add bpc property to devicetree?
