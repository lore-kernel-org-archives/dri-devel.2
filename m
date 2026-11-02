Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E1606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RfxSXReO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7054410E516;
	Mon,  2 Nov 2026 04:32:31 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641D310E00C
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:25 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-35b2c599f43so4024329eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593944; x=1794198744; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Bqd6rCNPSXxAR3I72cEucGZxSgqBsGLhAkb3kN5Zr4=;
 b=RfxSXReO/5PEU0UjFl5/qkgOXeMmOBx7n4mCjoaNL8dnpJXSh0qdTOgTodUIYgxLio
 AVampJ0Hl+aCbVtCk7HH6wTGrKMipmD8E+SfznFFN80Nf1n5wVbJOuiWQVjQaIMZB95i
 w/pOe7lNqwqmgCHd56wVrd6GhYY9NMQhXYLvB6Ub0EDwbhXPvmaPIq2cRxbdBULyaaq8
 TTAGjp5TIhIRjs4PVD13EoiHUBeYaL3e/Eg7gcM/l1cCLCxQsbOO4Le/k2nTujvgHr/V
 HPjWc9xYwPoSs5gMR75ZjrOvxVRhhEOenn85G0Mmra6MNNypnF+nFItzDrqz4/90ITsV
 maNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593944; x=1794198744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Bqd6rCNPSXxAR3I72cEucGZxSgqBsGLhAkb3kN5Zr4=;
 b=z9bO0XaVnpiDYLy2dr9KBInVZigVpRH92c8i+qzIbd8M/WzsXuo+kV66kWiThf7Ged
 wIHAoB7jAiF3XP7eXbpl0PcJZTaTtv2Qsuanqyh7Nq6ZyY1+COggdsLCcyEvtmuLtDeN
 cEmiLgeGqYHNJ7wIFMRcfrv5W5aNMtl67GDzWMuZe+C/mWT4eJrmiAJjX4QOba6CrRMp
 7GblLX/1pVpkHDFCSFC9qZZ+6jZqV7jGIYuMXS/VOVitxq5aOmyCSFLD/lzW9Q1cJS8R
 nUZQyNDtvH5GuTLl1oMT9oSHx1mTu4JVmFqlSuq3XPm1w4QrXbnRqGJH6h4NDRif9nPw
 UVTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQn/Fdrvc2M4E0KR2rLlh3FqwyDdYRwyaekAjau2MDg9yjW6c/BXHx8yGQlVyCSPLvgD7/y4RAbrg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK337S+2l/9/5rNURUugbOzKslwM2z0yxXwqDHe0II1ETDtBKR0
 rh1zG6QIAsSV71FzDKBgK9LTwU/BMayLuYGhYlR8Y4unm24x9wMNQhlD
X-Gm-Gg: AYBFou2qEzvzx5LDnyEcNGjlXrURSqIW0EQ87rrs9REhHRCvZ7Ke9ORTyP8kmVdjTeS
 iqiE+vpIx/uTMJuM/cd6KTf6eNjjRt4fxoJPZ9xnM4yqZF+lSbQ3148UCq2rYQS1sUIOwb44yGx
 GucJngfVTKPbR8eZFfBuuaxmBaBkLDtDNNCQRrbUXqAS/3VkabYR+c75X3qOdKA3NzKstQHXTbC
 54J+CHA5CXe0eG1f6E/wLex/0PBTFCZrIcEQkNx44YfJoDyAScgtHz3nkHbuK1d3CwPOw/JohKs
 JsRYTZpBnMSSh+T4CTyI1FYvQj2S9UDK2cs8a8j7VCFfXZLf5seV3NglcYPKA3Npzcz3NlEDT2p
 /tpSTOKVyIxghQLaPMPdgu61vJPykWCRzIjUBfuev5aOm3DgiPR3wftyUQULdnALyrseWfohv49
 Pra8bsbMSExUl491XqLBRcd5LYTg3V9vJS/ex56iRJ2ZIu/nZRLpdhNkv8sUFdlqsYRCdr+7cIf
 hTGAmZfBr2YrEJrp2jc/1EKoYzYbvmSoLe3zog6qfOJTMWUL+JfFGYFd+8vcs74Hle5E1uA30dM
 HCif7klzW7z4Z9vtGTcJ1NjA0WuEcUSnvlm8JD4Hn/6TQa8btEPNN0LJao8You8At79RNEVmRjA
 pR/khlX51zahRr6sCg5j8kzKDVpyHpMi2DiG/L4I=
X-Received: by 2002:a05:693c:41dc:10b0:351:2958:1740 with SMTP id
 5a478bee46e88-36a42445a8amr14044282eec.37.1793593944389; 
 Sun, 01 Nov 2026 20:32:24 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:23 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2 0/5] drm/panel: Use mipi_dsi_*_multi() in feiyang and
 rm68200
Date: Mon,  2 Nov 2026 12:32:10 +0800
Message-ID: <20261102043215.990351-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series converts the Feiyang FY07024DI26A30-D and Raydium RM68200
panel drivers to the MIPI DSI multi-context helpers, as suggested in
Documentation/gpu/todo.rst.

The first two patches fix pre-existing prepare() error paths that leave
regulators enabled on failure. The following two patches convert the
DCS helpers and initialization sequences, with command failures
propagated through the cleanup paths. The final patch normalizes the
RM68200 hexadecimal literals.

In RM68200, initialization errors were previously only logged, allowing
prepare() to succeed despite incomplete initialization. The conversion
now stops subsequent DCS transfers and returns the first error.
Thanks to Doug Anderson for reviewing v1 and confirming that this
fail-fast behavior is appropriate.

This series is independent of Osama Abdelkader's
"drm/panel: Use managed helpers in DSI panels" v7 series, which modifies
probe() and remove() rather than the panel callbacks and initialization
sequences.

Neither panel has been tested on hardware.

Changes in v2:
- 1/5 (new): Fix Feiyang prepare() error cleanup, as pointed out by Doug.
- 2/5 (new): Fix RM68200 prepare() error cleanup, addressing findings
  from Sashiko and Doug.
- 3/5 (v1 1/3): Replace the Feiyang initialization table with seven
  direct DCS _multi() calls and use the new error cleanup path.
- 4/5 (v1 2/3 + 3/3): Merge the RM68200 conversions, as suggested by
  Doug, and propagate initialization errors through prepare().
- 5/5 (new): Convert RM68200 hexadecimal literals to lowercase,
  following Doug's suggestion.

Validation:
- Each of the five commits was built individually on arm64 with W=1,
  without compiler warnings or errors.
- Checkpatch passed, except for the expected msleep(10)
  warning in the Feiyang error cleanup patch.
- Mechanically compared all 58 RM68200 initialization calls against
  v1, confirming unchanged command addresses, payloads, and ordering.
- Verified identical compiled code and data sections before and
  after the hexadecimal formatting change in patch 5/5.

v1: https://lore.kernel.org/all/20261014135028.1438841-1-hungen3108@gmail.com/

Hsieh Hung-En (5):
  drm/panel: feiyang-fy07024di26a30d: Fix prepare error cleanup
  drm/panel: raydium-rm68200: Fix prepare error cleanup
  drm/panel: feiyang-fy07024di26a30d: Use mipi_dsi_*_multi() functions
  drm/panel: raydium-rm68200: Use mipi_dsi_*_multi() functions
  drm/panel: raydium-rm68200: Use lowercase hex literals

 .../drm/panel/panel-feiyang-fy07024di26a30d.c |  81 ++---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 285 ++++++++----------
 2 files changed, 179 insertions(+), 187 deletions(-)


base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
-- 
2.43.0

