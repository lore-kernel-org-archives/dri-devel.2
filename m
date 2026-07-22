Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620E8C531D1
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29D910EFD7;
	Thu, 23 Jul 2026 07:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=auditcode.ai header.i=security@auditcode.ai header.b="JZFNOGOJ";
	dkim-atps=neutral
Received: from sender-op-o18.zoho.eu (sender-op-o18.zoho.eu [136.143.169.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A695010E283
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784745092; cv=none; d=zohomail.eu; s=zohoarc; 
 b=R0xqHTcYL563VWHM1IOUDSUEi0vA9qHw4/jf2IXEOg9VNDv5UBTzSrI3T4xrqCeBkd5cCoUhQqNY3WxhyA6yB6LzzzA/nVmr6fUrW/1QRINU/ICeYEdRKPrjTUBLLF/2occhsM7kHhU1FR0ZO0+jgJXc7UWZmCAofyA+fk88gPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1784745092;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9teqGLwtqZkTTCMOoTf/Re8JjZcZRX+7VdE68OzbwmU=; 
 b=Kf3XNpUwXnynBj4qJnHbrW6kWIu/ZZbNfz07jQr992wQTriBrrMvZ74xERv2JH9d7K9xSG2IIAx/a9FW33RlEFkIHjr9K9A76tOZ781/5XAaUgBS9oNRew7VqFvZTN9yo88kfPrYvE33NneX+Dw4T57JPLSzkc/LQ/74dbr/Src=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=auditcode.ai;
 spf=pass  smtp.mailfrom=security@auditcode.ai;
 dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784745092; 
 s=zmail; d=auditcode.ai; i=security@auditcode.ai;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9teqGLwtqZkTTCMOoTf/Re8JjZcZRX+7VdE68OzbwmU=;
 b=JZFNOGOJ7odj96BnXCCnh7lrTc+tbRBUaTtcpTGcOsMthqpBI0HwbY0uHczG63H/
 qsICRXxAJOKNSMlc68kY4LuWzJwZP2MCHYgsZhNdonpm3Sil8nmB9XaQKMn3rg/X6tk
 SA1vOZMBL/BxVUn2ldQBW2lOgBlm1QtDIj9TuM54=
Received: by mx.zoho.eu with SMTPS id 1784745089785712.2097800057014;
 Wed, 22 Jul 2026 20:31:29 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
 mripard@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdir and
 .detect
Date: Wed, 22 Jul 2026 20:31:27 +0200
Message-ID: <20260722183127.40522-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com>
References: <3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

> Thanks for this report and patch. I am currently working on a series
> adding even more stuff in vkms_config, so I am trying to solve it for
> the whole vkms_config structure.

Makes sense -- a structural fix for the whole vkms_config is better than
my one-off rcu anyway, so please drop mine.

The refcount-the-connector direction sounds like the right one: the UAF
is really just .detect depending on the config object's lifetime, so once
it holds a ref it stops mattering who wins the configfs-vs-drm race. Cc me
on the series and I'll run the original reproducer against it, so we know
the exact race is actually closed.

> do you have the script that you used to do the hammering?

Yeah. A thread hammers .detect (which walks the whole connector list)
while another rmdir's configfs connectors out from under it; on the
unpatched module KASAN reliably reports slab-use-after-free in
vkms_connector_detect. I'll send it over.

> can you contribute this test to IGT?

Happy to. Point me at a close-enough kms/configfs test to base it on and
I'll send it as an MR.

Ibrahim
