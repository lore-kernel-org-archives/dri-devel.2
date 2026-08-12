Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA8EC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705D210F26C;
	Thu, 13 Aug 2026 09:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="II8x4sSE";
	dkim-atps=neutral
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098B810E118;
 Wed, 12 Aug 2026 19:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786564074; cv=none; d=zohomail.eu; s=zohoarc; 
 b=hTbtk9mdnFSPdsipOAwgHi+spTblPoZtWMKuJ1JwwbhuK3hQLcjBtu3yGDWwRdLJFr/Ny7gP+h1tQKCgI5jYAshJ6AdLYLdgbg6ZgtFvaYt5GOhEfNpWyqC1VqFUQZsLCNnPyValDRgUgMABKtk7P4P/omoCOmCPEG5homavqZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1786564074;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mvscGV9BAjiM99498gHkRCfZKDdtsbR/zACjdQdWcqo=; 
 b=NTRCmOloG6xfGjMtNtClsUVuZBa5fh/IDcSiuMP/K1M6hpFDAN8FL6xSGZ0wiwDFXcactMzPKPXb5Ak2p6QrFAN0PjLTcC1UUyQBsJWEhiuGoFQeY6BTK0IaCSaEtMxzdr5YRRWIF/45AjrNW/ubMiiqxs3hB/vtdPI0tjQZq7I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=iusegentoo.com;
 spf=pass  smtp.mailfrom=ali@iusegentoo.com;
 dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786564074; 
 s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mvscGV9BAjiM99498gHkRCfZKDdtsbR/zACjdQdWcqo=;
 b=II8x4sSEgRg0hJzhSry0XOzkC8TKFdLbkdcFYG3nTx/l1PUE8vye9hgIP2TszxHu
 hbO/EUZ5YjRAJgKCtaw8r3pk2ZOUE+FMJOUDjKFuAnJvfQop5x9WrkAU2i8IaGeQn0c
 m5NVon1blcfd5mFR9WZJudBCDncyxXY63t6fafVA=
Received: by mx.zoho.eu with SMTPS id 1786564072583712.1442461699686;
 Wed, 12 Aug 2026 21:47:52 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/xe: kill the secondary bind queues on multi-GT
 teardown
Date: Wed, 12 Aug 2026 19:47:39 +0000
Message-ID: <20260812194741.273853-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806201455.340244-1-ali@iusegentoo.com>
References: <20260806201455.340244-1-ali@iusegentoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

Hi,

CI never ran on this one:

  Series author address 'ali@iusegentoo.com' is not on the allowlist,
  which prevents CI from being automatically triggered.

  https://patchwork.freedesktop.org/series/171752/

Could someone with Patchwork rights hit "retest" on that series? And if
it is easy to do, add the address to the allowlist so later postings
trigger CI on their own.

I have no multi-tile device and the patch is compile tested only, so a
CI run is the only coverage I can get for it.

Thanks,
Ali
