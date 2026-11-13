Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC28606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Au6AAUsk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7ADC10E7DD;
	Fri, 13 Nov 2026 13:04:52 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB9B10E7DD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:04:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id B09BBC4F776;
 Fri, 13 Nov 2026 13:04:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 01C1A60015;
 Fri, 13 Nov 2026 13:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED23311BC1A33; Fri, 13 Nov 2026 14:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794575083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uJDbNGEvEPuyHEi4/1DJ4jhZX8PG8UyJOf76Gs/epng=;
 b=Au6AAUskR9cowvdwGlEfrmhMnCt3P9UapTjafWmwdm1QpBOrVKpCMwsfv3q7uIP0yRFZo2
 euCBuAXz2rdO2FIBC/0c2hdW2N0aM2KiOLZpPf1NOnijSBRcBU7sYhliQebZ+frKKJIbfG
 11tICCqCuVeSXc7tfyqj7kyZaec15uqcT9MI74IknpXlMk8IL4ZwX0gzIEXZc47yabiGea
 tB/Hge3JH2pZJlY04e02pgIXXQKMMxNU9qlsOmKP8AvbEAzY7gtkbWf0ObaV+VY4Kqektn
 6eOAmxRXR3lT68D7x5BC573JePOLLSu1TyllnG8bvjm6Uq/Db5IQkRUp+P7bLQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261113114552.895592-2-manuelebnerli@mailbox.org>
References: <20261113114552.895592-2-manuelebnerli@mailbox.org>
Date: Fri, 13 Nov 2026 14:04:24 +0100
Message-Id: <179457506498.2156325.15213734004250647816.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 12:45:52 +0100, Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

-- 
Best Regards,
Thomas Richard

