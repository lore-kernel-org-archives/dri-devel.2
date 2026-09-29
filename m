Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489ECA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFA710F36E;
	Wed, 30 Sep 2026 12:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4/ddbfS";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6543C10EFE3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 17:50:27 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd77300825so24289985ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704227; x=1791309027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DurJlfglRtxfoYGfZICWlyKpb6JqelzUeYbLyKTge0E=;
 b=S4/ddbfS6YjIUonyS9IdsM/QsSHKcpakvi5sgv3XJt0a5k/JK1/Lp7DjqEb+tG091v
 kDtBW+HGWWBUd7GzGI1nqKg3yy06Smqfbb4F75Tt92P4OZsdxcpr/HCZhTDRcB7DSX3c
 euOvm2ZeGJB6homoG6xtxQhaeRPRE3L2GpRXAUH4NIE3JkBguNL85mH4drzlSAFr1CRD
 293GXy4C6Ban7MmmZhU+rQq9Adzo8p5Wh2y2f0EHpwT/fEzFKKkndkIUwCTMEOA2iIeI
 eKqJuTgfBANcaefgw9tc1GjIORFvW06SWr+uKcYfTKUV/+wgc4NmGbsEJmKBakSQjoXK
 G6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704227; x=1791309027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DurJlfglRtxfoYGfZICWlyKpb6JqelzUeYbLyKTge0E=;
 b=yJjNuSPLRG/b3iVQDQdk3S6kbKVPDn6SER6G2EGAgwjWQQV2/4hljpU+I2Q+faxPuP
 EJa3CU+yHZZNOBeYDRaW9nkxO/ImvvWeQcSEjDM/IRXo14aCQcoR4PMLV4ExRAB1jBE1
 F/428ODqOXe8+eLL1YXwiSMuNY+2fioZHkp3Q+oZqxddR/SSVLWfVhbUwV5LyX4WkS8Z
 yZEz0Vziy82UJrVIBM2K36+Rjt8RZqsJEjjM2hrWh4GF2GRRTlU5+xNJ8GoSs8d8Ssvr
 RMUg6ZmIIiSrrDh0MieUB2JTCxnE3UxOBIWHnrLydLkSRhnDk5rkupyX0Xx+B8qWcr5y
 L+Rw==
X-Gm-Message-State: AFq9FYIYT/zSR3mFHJnUPCXBoi6t7ITBXQoiybZM7EDZvYXiatEZU+Ei
 6luKO0ph0a8XzwCh5gwtKFxu1iQOnaLOXjOt+DfcjDbHQILELVy/7uS9
X-Gm-Gg: AYBFou3/exLdvWxjl6zBCGaPFS9fqPtK4gLr0BtVoqQST80yJJdbm360RhdWowcWhcQ
 OnHMeLCPJqEhj8y3g7d3RsOkTLAIoLMtm/GliGtOtEY5i9UyzDFYG4JgKN/r/rBnukS3cOeaopo
 IjovNlV0NWdokTYXYGp0F9cO+I9Ij38xn9b6VERiVgdQOi1KpfHlnOwj8avSNJu00PqRuqyc7ux
 do6fO9PFBv4EjUlNSW5YtPkafexwmyV7WscMsc5w0Yx3D3EMWlXaAi7STqGXDd7wDKbY5URhNDy
 CQUiZWHZebmLYi8Ee4V3ygMFnJzQlUgE1hWv+ELraUpmSz4JC+ZGjuAeDxfmOVn1TRjFXMdoys/
 HYs2e5h+IArsJzBwh0nBuHwx7J61j2TulcRSuLdnEC3HFESvEGlG7C0W8x+W8YAMyoLlW+0HLt8
 rgPOVx9/BfDG8Sm8XkfiI+sIGx8pFprp1b7Ly8Ctwaty5sw6CWrf+sB89oz/qcQzoNzXBRlpRoH
 bBDLs1kYkIeRQ==
X-Received: by 2002:a17:902:c406:b0:2dd:9b53:f9ba with SMTP id
 d9443c01a7336-2df7da5e366mr158748795ad.1.1790704226719; 
 Tue, 29 Sep 2026 10:50:26 -0700 (PDT)
Received: from DESKTOP-NM9EKIA ([125.134.240.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2c794166fsm15247035ad.21.2026.09.29.10.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:50:26 -0700 (PDT)
From: Joonhoe Kim <26rote@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, sashiko-bot@kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Subject: Re: [PATCH] drm/msm/dp: hold one runtime PM reference per plugged
 state
Date: Wed, 30 Sep 2026 02:50:19 +0900
Message-ID: <20260929175019.3899-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260929132029.911491F000FF@smtp.kernel.org>
References: <20260929130627.959-1-26rote@gmail.com>
 <20260929132029.911491F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

On Tue, 29 Sep 2026 13:20:29 +0000, sashiko-bot@kernel.org wrote:
> Then, on the next plug, msm_dp_display_host_phy_init() will silently skip
> PHY initialization because dp->phy_initialized was never reset to false:
[...]
> Can this sequence leave the hardware PHY uninitialized on replug, causing
> link training to fail and the display to remain broken until reboot?

I tried it on the device (Lenovo TB323FU, a DP monitor over USB-C) by
delaying the unplug handler by 5 s and forcing a detect in that window.

- A normal unplug already leaves the PHY initialized across the
  controller's runtime suspend: msm_dp_hpd_unplug_handle() only calls
  msm_dp_display_host_phy_exit() when sink_count == 0, which it was not
  here, and msm_dp_pm_runtime_suspend() does not touch the PHY for DP.
  With this patch the controller suspended after the unplug, and a
  replug 20 s later trained the link with phy_init=1 and brought the
  picture back. The controller's runtime suspend does not power the PHY
  down, so the flag still describes the PHY correctly.

- Tearing the PHY down in detect() when the sink is gone (the natural
  fix for the scenario in the review) made it worse: the next detect()
  initialized the PHY again and hit

    phy phy-88e8000.phy.3: phy_power_on was called before phy_init

  and the SoC reset shortly after.

So I would keep this patch as it is. detect() clearing plugged so that
the unplug handler returns early is older than this change and is not
affected by it.

Thanks,
Joonhoe
