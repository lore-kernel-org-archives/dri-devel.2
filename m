Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC5FCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59C10E730;
	Mon, 22 Jun 2026 14:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="hmbYUvFr";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A3710E730
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 14:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782139955; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dW5ZeRxS3qPytU0lzkxz4s13hzmnPWsKg689XXmfNTr/ddO1U4NNKVCWzuMsxHCgC//MlTbBXoT9A1VnHLcsa+eHKKxxKAOo5brrTVEq+MRo1Tq1yEOHRfqsHDXh7ERGpsmfS3biNgDokXmDP9q2hJFWe84yrFCbkh2SKHULDBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782139955;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=63C3hkJcUAjLx1Wo5SqhN4nguOHicwdTIcrGRX6qKsE=; 
 b=Rii7LhF9fHVDGzutkRawRV2OdwW2hvqmy2aFMycBWiOoKy2fRW7L1QbQLICpuJwljQBd7Fj0UtiCgsvtLpAptJggtp+clgV6/fkFDX3pUrt7bSpJRf085VUqFYRz024180l1zsZuY3eZ8Wj3uTdY649ECr8glYXCVXzDNnA0sMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782139955; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=63C3hkJcUAjLx1Wo5SqhN4nguOHicwdTIcrGRX6qKsE=;
 b=hmbYUvFrPTvYG6u0375xE5vh8ARJ+vYDHadR6t5zrg8xQEozuhXg/cab1+uwm+hv
 QNr5pxy2OurBLuamZdwkPSWrVQasm5U24t0sj4HrKC+pMeFYNYeNVZ2AqmioeiGhWrh
 m9Rfz802G3KAyQWWdeBWX//FNyjNJ9zBMj2ds7IA=
Received: by mx.zohomail.com with SMTPS id 1782139953275703.0554772907994;
 Mon, 22 Jun 2026 07:52:33 -0700 (PDT)
Message-ID: <18568da132dabb8594ae9eee2c8c2f3cb1fad04c.camel@collabora.com>
Subject: Reminder: Call for Proposals open for XDC 2026
From: Mark Filion <mark.filion@collabora.com>
To: dri-devel@lists.freedesktop.org
Date: Mon, 22 Jun 2026 10:52:32 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hello!

Reminder - The CfP is now open for talks, workshops and demos at XDC
2026. The deadline for submissions is Friday, 3 July 2026.

    https://xdc2026.x.org

While any serious proposal will be gratefully considered, topics of
interest to X.Org and freedesktop.org developers are encouraged. The
program focus is on new development, ongoing challenges and anything
else that will spark discussions among attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more!
  =20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

Best,

Mark
