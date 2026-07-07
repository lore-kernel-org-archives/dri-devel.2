Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C115C44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA33410EB96;
	Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DO4gUTwR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698CE10EB89
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5324F4351C;
 Tue,  7 Jul 2026 07:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D2F1F000E9;
 Tue,  7 Jul 2026 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409611;
 bh=FCWBgXZf3qnampYaWbK+IOo2I/FywmPizrCWO9/t39U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DO4gUTwRHzgGfos3HyXKRzvKkB76qfNzgvn4u+WpAxJZO5ceYbY0xIj1ZoYrJ4f1M
 zRq+k2jNOmtEF4mFQJuwDCzbJcNtz8BXuIMoGc/9+EW5eZZ0t8vxKOQ/kf5ZVJg6Y2
 GAbYkBxqEVESRwGJBbDtfZEUUWP7iDFAheBbf362K21nQDm8EXQORDKzRo3pyB4UBk
 dfHVCdgkrxKIoV4VATHigAD07rim0uvTPCcLBAHKLYFxlDFL+wdHu4YjEgKmOd8ZbX
 yZfH6yc+8xr9hBAU6FXrTD8EH7UIcmr8AkTZad/QTNkF1ZnTiqbTgskwzMka2547EL
 l2uvu5k4VzP6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/40] dept: add single event dependency tracker APIs
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 ojeda@kernel.org, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, tytso@mit.edu, cassel@kernel.org,
 linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-3-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-3-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:30 +0000
Message-Id: <20260707073330.82D2F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unsafe macro conversion of functions causes double-evaluation =
of arguments, leading to logic bugs and memory corruption.
--

commit e5795ffb367b1b68ef8574b0a67f0bf3654baf77
Author: Byungchul Park <byungchul@sk.com>

dept: add single event dependency tracker APIs

Wrapped the base APIs for easier annotation on wait and event. Start
with supporting waiters on each single event. More general support for
multiple events is a future work. Do more when the need arises.

> diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
> new file mode 100644
> index 0000000000000..0535f763b21be
> --- /dev/null
> +++ b/include/linux/dept_sdt.h
[ ... ]
> +#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
> +
> +#define sdt_wait(m)							\
> +	do {								\
> +		dept_request_event(m);					\
> +		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
> +	} while (0)

[Severity: Critical]
Can this macro evaluate its argument multiple times, causing a regression
if the argument contains side effects?

Unlike sdt_might_sleep_start(m) later in this file which safely captures
its argument in a local variable __m, sdt_wait(m) evaluates its argument
twice.

If an expression with a post-increment is passed to a macro like this,
the side effect will execute multiple times. This is especially risky
if existing synchronization primitives like wait_for_completion(x) are
converted into similar macros to integrate with the tracker.

For example, looking at drivers/vdpa/mlx5/core/resources.c:

mlx5_vdpa_add_res() {
	...
	while (completed < issued)
		wait_for_completion(&cmds[completed++].cmd_done);
	...
}

If wait_for_completion() or a similar wrapper evaluates its argument twice,
completed++ increments twice per loop iteration. This would skip completion
entries and eventually access out-of-bounds memory past the end of the cmds
array.

Could the argument be evaluated once and captured in a local variable
within these macros to avoid this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D2
