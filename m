Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F7C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7233E10F1A7;
	Wed,  2 Sep 2026 12:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="Jd4MAbsr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCjSrcyN";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4857210F1A7
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:25:49 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1788351947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/C5jHO5KGjc1uyhBAXwASd+Pv7sP5Fby0HfqQuui0CE=;
 b=Jd4MAbsrMX51++xbiIcBBT3jkVzbG7sssQ8C39uuRgS1rrFyQpwkuMyfLr5NuXRo66t9CZ
 NZVIs/H4S4AKfsPybOTBOXepvvLVnDwLfKiBKS+bIdTEMxl2WfqO9vopG9fIjTazdnIB8D
 fMlF0tfqyKEDq4JNuSbh1poBNyd7f8JMA0rrO6pUJ6E/s7dc99bbKCS7ZjMxA6rjrFTemw
 lPDYKSMoY03Y2uCIpdtaB8feXnoJw0H0MN8MJtTNO8LJtTqzAzWsDWInehkC5I0Wu1IVIv
 gIAAgM6WC+Ox4gUggzyoDDvt+JMgCm3uF3TQaJa7KjWMR/3WyJqJRqXQE8vSlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1788351947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/C5jHO5KGjc1uyhBAXwASd+Pv7sP5Fby0HfqQuui0CE=;
 b=fCjSrcyNnRY78KBlVexoMvhb9JK3qVVVKxn8N5W9rvlfnm4A/CM7mM70PfenD8qStnQ3Gy
 Xt/jps03OVFHcTBA==
To: Anshika Jain <anshikajain196872@gmail.com>, Andy Shevchenko
 <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sashiko-bot@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Anshika Jain <anshikajain196872@gmail.com>
Subject: Re: [PATCH] staging: fbtft: fix len<=0 buffer overflow in
 define_fbtft_write_reg()
In-Reply-To: <20260902045026.7442-1-anshikajain196872@gmail.com>
References: <20260902045026.7442-1-anshikajain196872@gmail.com>
Date: Wed, 02 Sep 2026 14:25:46 +0200
Message-ID: <87wlt3vnzp.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain
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

Anshika Jain <anshikajain196872@gmail.com> writes:
> This is a latent bug: nothing in the current code prevents
> two adjacent negative values in an init_sequence from producing len=0,

Can you elaborate what you mean by "two adjacent negative values in an
init_sequence from producing len=0"? How is it possible that negative
values in the init sequence causing len to be zero?

> and there is no guarantee future or out-of-tree panel definitions
> won't do so.

Basic testing of future drivers would prevent such bug. It is not on any
rarely-executed code path.

Nam
