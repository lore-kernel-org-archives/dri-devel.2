Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D4CE99076
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005C810E161;
	Fri, 10 Apr 2026 10:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAk9iV9I";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD6810E161
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:12:05 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d04fc3bf2so1089462f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775815924; x=1776420724; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V2xXUchh2By+ghGGZBk84vMcNEj5jYwmcow9AN3NHu8=;
 b=FAk9iV9I+08DvmEdES0KqU049Z7AT50IuAGVepvqzARlSHS5inL7f+qR6ScCTSxPkF
 OGxueEy2/lsZEUlGXZQ9ljjlMZj8JehXuybjJGURSHJlfbQhxvvpDnEnlQWDuncy4S8m
 kH/UJbBAhwXf+p1US0Sce1Be2M5+ruuATZrrSTghLFgdRSZrBSDRzGuiChYFWpa64FhJ
 mSmnKBNfy+0gABqW+PqqvsZHNxqBSt0Wn0ggedsgKZr1O+iyp4FZpCtkxk9jIy3hdSnE
 ojV7Q34BqPGTyorCTe86kstppNWPM7LIhWb/1buiphy66efRTUphr5tby1UfITFrMRGy
 QSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775815924; x=1776420724;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2xXUchh2By+ghGGZBk84vMcNEj5jYwmcow9AN3NHu8=;
 b=kwQZCfBkmRGEEh1kdhZqO7WxymgOeSU8guugzmxOGcZpVdn/rdPW/6h+DHbBhP7ctV
 rX2iO/wmK9JVJQ7GGJ7B27SupcLndof9cN343HOkFfbmF+IHkHIyE9pMAMJ8gtPumr2Z
 HZey6iA780Od1M3w6BQH3kjKlQF5WXjhs9D+5zy53686pLEgKCVfnKhxU/xAP4vv3bgk
 xEG6tkq9nzfsCVPJhi0qOZzBX43KwuVZ/jL5CzRAqTIxtDbH6ddRYGk577QLnhfjmaMc
 hVLiAEyU+hqWHKgK9VyV796ET4T9O0g4IvSMnB71UjEENTNjKfDkAVIYHLSR8OeVGvNw
 uOoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQb4lTw3KW+jKzLsY75ORooFSWJzvRPNIk32MWIuWHZj1VIBygjBAX4T/Gwrv966pY7P/rnuRaYHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyUSXrAhV6VgRiJJV7pxPF+VHSctXRZnVDVqgrTyxnzGRIpsTp
 MrBLvtmPAVfLptdaTo/R4g3H/L+8DM74G9hPHP3jmW32op/DRpwapbrA
X-Gm-Gg: AeBDieupr35lqM+mrNWxiqoNSOyOUANJBCTxUfoU8E7ax5b811RdiPumJCO2n1Y4FEW
 9aZu4gIeXNyNJfrzarHZnBMrvo779LGtO2ySKr3PwhqKn7Oe8wfsJ0URKPYQIy9J7Y02yrNGljo
 JrhxSoCKScv6LbOe20m63+P2Q9quna5sW/1kNaFtGHOOH39tmLc76WxO6wPmyuXwzJhMEkqNF6N
 BomE0sFSAI6ynBjBos4xrP7w3A1QMLtKJC5ZpQaT+qZMC5EgfiHo475LRcRoqvRzdEQLdKplM79
 wMl12RCEmww82Qjk88Hsr9Ik6ViDIEEaaD5BDHHYDTlg8gPfK8kGb9ZqoAmblfauN1xaTZaKw8k
 66ppK4BtFd6yZ6sd2lJf/WfK86OP40J/d9kwz1VjA9VXqZclWA7fSKd2hUsa5kavuufR3gzoW7X
 d4DK+SOpJxwHjbfYxWLkc=
X-Received: by 2002:a05:6000:2013:b0:43c:fe66:43e4 with SMTP id
 ffacd0b85a97d-43d642b8ecbmr4197977f8f.31.1775815923730; 
 Fri, 10 Apr 2026 03:12:03 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50289sm6507349f8f.28.2026.04.10.03.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 03:12:02 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:11:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [bug report] drm/bridge: add a driver for T-Head TH1520 HDMI
 controller
Message-ID: <adjM7-DcN_6KvbE7@stanley.mountain>
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

Hello Icenowy Zheng,

Commit 96f30ee0fb9d ("drm/bridge: add a driver for T-Head TH1520 HDMI
controller") from Jan 29, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/bridge/th1520-dw-hdmi.c:139 th1520_dw_hdmi_probe()
	warn: 'hdmi' isn't an ERR_PTR

drivers/gpu/drm/bridge/th1520-dw-hdmi.c
    133         plat_data->output_port = 1;
    134         plat_data->mode_valid = th1520_hdmi_mode_valid;
    135         plat_data->configure_phy = th1520_hdmi_phy_configure;
    136         plat_data->priv_data = hdmi;
    137 
    138         hdmi->dw_hdmi = dw_hdmi_probe(pdev, plat_data);
--> 139         if (IS_ERR(hdmi))
    140                 return PTR_ERR(hdmi);

s/hdmi/hdmi->dw_hdmi/

    141 
    142         platform_set_drvdata(pdev, hdmi);
    143 
    144         return 0;
    145 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
