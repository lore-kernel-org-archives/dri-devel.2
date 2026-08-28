Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBCDC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8129D10E687;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=sarx-technology.com header.i=narek@sarx-technology.com header.b="aXpNSIpx";
	dkim-atps=neutral
X-Greylist: delayed 906 seconds by postgrey-1.36 at gabe;
 Fri, 28 Aug 2026 19:22:44 UTC
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E0110E4E6;
 Fri, 28 Aug 2026 19:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787944049; cv=none; d=zohomail.eu; s=zohoarc; 
 b=aDBlNgI+LxEsuMdiIq+7SapyFjtseiUlLSWJl4vrYExkXrX/2eI9QVU2nPAwQYGeZdnu9l1HOgrebF3zDLPhzp13UKkWLUrSTaOTaZZDI+RPY1Xs346pITR45uQHjt2VZxwflOetzElvzrHo4oDFVLHqr+xyQQLgFlCvYGAxVT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1787944049;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gUYYdleVR1v9SIJM9KGBpXqJIpkgjBCiNeo1NDaWFWE=; 
 b=SbwlzIjYqz8hhZ1SDav1mpV2mntpLzKaXFBR8kKkDhLjVs8YebZj+GUQrDmQBSG+D8kH6bLx3khaHBpsaxj5JCNn6Phne1goAHhm4ZTtDVqU9dhcd9Rq5W4eJOj+CGW/0uLNkyJgeP+cD/sGzii2D2huq0k6jjaotg7haiIOj2o=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=sarx-technology.com;
 spf=pass  smtp.mailfrom=narek@sarx-technology.com;
 dmarc=pass header.from=<narek@sarx-technology.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787944049; 
 s=zoho; d=sarx-technology.com; i=narek@sarx-technology.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gUYYdleVR1v9SIJM9KGBpXqJIpkgjBCiNeo1NDaWFWE=;
 b=aXpNSIpxn/EXKangzcBmZcEl6ovKKBAcgF6l/KGTEFbir64kkizkSz6swoQf7ePA
 lFHlRmYkGJoHBpYuCw1VzdjIK+1uTi4NDpqomCn3eeVVdiHuN7+ie7OO4L601HZaWvS
 Y2I24cYq772rcV7IC7Qd08U5qWz2iUJYvEzj4xhw=
Received: by mx.zoho.eu with SMTPS id 1787944047881609.5959396225994;
 Fri, 28 Aug 2026 21:07:27 +0200 (CEST)
From: Narek Sarkissian <narek@sarx-technology.com>
To: superm1@kernel.org
Cc: alex.hung@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, kernel-dev@igalia.com, mario.limonciello@amd.com,
 mpearson-lenovo@squebb.ca, mwen@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH v8 5/5] drm/amd/display: Fetch the EDID from _DDC if
 available for eDP
Date: Fri, 28 Aug 2026 20:07:27 +0100
Message-ID: <20260828190727.58724-1-narek@sarx-technology.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fc3f474b-92bd-46b3-919a-dec8ea105b86@kernel.org>
References: <fc3f474b-92bd-46b3-919a-dec8ea105b86@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

Hi Mario, Alex, Alexander,

Following up on this patch (c6a837088bed) with a regression report on a
different Lenovo model.

On a ThinkPad T14s Gen 3 (AMD Radeon 680M / Rembrandt, DCN 3.1.2), this
change causes the internal eDP panel to be capped at 60Hz even though
the panel natively supports 90Hz. dm_helpers_read_local_edid() finds
an ACPI-provided EDID via _DDC and uses it unconditionally, but on
this machine that ACPI blob is a stale/incomplete copy of the panel's
real EDID: it encodes only a 60Hz detailed timing, while a live DP AUX
read of the same panel (Samsung Display, ATNA40YK08-0) returns 90Hz as
the native/preferred timing plus 60Hz as a secondary mode. Both DTDs
share the same pixel clock and htotal, so the ACPI copy looks like it
was deliberately downclocked rather than being a different display.

dmesg confirms the code path taken:

  amdgpu 0000:33:00.0: [drm] Using ACPI provided EDID for eDP-1

Booting with amdgpu.dcdebugmask=0x8000 (DC_DISABLE_ACPI_EDID) skips
the ACPI EDID and forces the live AUX read, which correctly exposes
90Hz and reports the panel's real vendor (Samsung) instead of Lenovo's
ACPI-authored EDID (manufacturer/model LEN 16713).

Full writeup with the EDID diff (byte-level comparison of the ACPI
blob vs. the live-read panel EDID), environment details, and repro
steps is here:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/5710

Since this same unconditional ACPI-EDID preference apparently fixes
T14 Gen 4 but regresses T14s Gen 3, an unconditional preference in
either direction doesn't seem to work for all eDP panels globally.
Possible directions raised in the issue: fall back to ACPI only when
the live AUX read fails (inverting current priority), prefer whichever
source has more/higher-refresh timings, or gate the ACPI-EDID
preference behind a DMI-based quirk table scoped to the models that
actually need it.

Thanks,
Narek
