Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D348AC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AAA10E25D;
	Wed, 16 Sep 2026 12:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="S5s282Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOsARUDc";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4A510E25D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:50:32 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1789563030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+JhpuGGvMdmNOgYncDR/qRYD0Xl8TCeVVwQFy7834Y=;
 b=S5s282Ot3+Cl4K2caSQMcqrsRWnyaAT9YU1HZYruN3O6mxOXJbiLHOSWUbFaKDJZBNV/tw
 ZPXsJoAlGo5ZGh/PUVnyeGEYm0sKsyIUxoP6fgsPkNqOOj4Ds34ASF6Qoe4ldOlPoKJYJZ
 g3fMuR0nhIDJ7rWED1/FDoy7Lo0hZZfWsXQFDWHYTmiw7JOTXenc2RYMO8jzjHAZ1JLA10
 8nCukFec4G+b02IQBZ91jwwS507k7aCUeT/upK8e1NCSwhUv3zwaFCIPVkSmXGKMc+EB1l
 DaHp1voyLv4jBGfdlz+BwS0fq2w1ofoVH+v+Fx7aBgdAnJZeHmkkcw0HHT7c9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1789563030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+JhpuGGvMdmNOgYncDR/qRYD0Xl8TCeVVwQFy7834Y=;
 b=iOsARUDcZvCRmPDbIOTtLhyZEvx7CQh/F9y3JDHsLwRfedcDm4wRZVhEi+pYmIA6t52Zvx
 gZL9AiRehpkmOVDQ==
To: =?utf-8?Q?=C3=96mer?= PALA <palaomer100@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
In-Reply-To: <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof> <aqp4GA1q6cLKivZo@ashevche-desk.local>
 <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
Date: Wed, 16 Sep 2026 14:50:29 +0200
Message-ID: <87bj9x5pii.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

=C3=96mer PALA <palaomer100@gmail.com> writes:
> Thank you for the feedback and review. I note the line-length
> formatting (~72 characters per line)
> for my future commit messages.Second, do you understand the difference on=
 what
> code is doing before and after your change?
> I understand that udelay() provides deterministic, busy-wait timing requi=
red for
> hardware register initialization, whereas usleep_range() introduces sched=
uler
> overhead and non-deterministic delays.
> Out of technical curiosity regarding the driver IC: theoretically, if we =
knew
> the exact window between the hardware lock/stabilization
> time (min) and the internal state-machine timeout (max) from the datashee=
t,
> would a range like usleep_range(min, max) be acceptable,
> or does scheduler wake-up latency make it too risky for
> timing-critical init sequences without hardware validation?
> I will drop this patch series.

A crucial difference is that we can call udelay() in any context, but we
cannot call usleep_range() in atomic context. Thus, a test run with
CONFIG_DEBUG_ATOMIC_SLEEP enabled is recommended.

I don't know if non-deterministic delay is an issue, the datasheet would
need to be checked. But udelay() is not deterministic either, for
example the CPU may need to handle an external interrupt while the task
is calling udelay().

Nam
