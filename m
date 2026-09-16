Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8B2C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBF410E7F7;
	Thu, 17 Sep 2026 07:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gwBwBowu";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE00910E1F4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:08:26 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 d75a77b69052e-530de452c33so7026991cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789560506; cv=none;
 d=google.com; s=arc-20260327;
 b=SnyTcfgJfMWZXxOZepZDfiL+Kf1euZ/84OS/t/xaTPguryVqK+/9Nfcda7LuY/QXGA
 B5zQeCv5q8XtCKPsyAQs9rO+5J+gQJ/HrE1cLPyHTmFpAa3EFWqnk6uvDOw9cbBndQQj
 9cp7kXCe4RR8ipxm3nw33n1U2Y/aLyQtxWV1li/LEHpMNKUb62TC6q05TKAQ6pzZweM4
 PG4ph2w64RZqMIvi0o+n279uogR0nwOWpxb6IcaHqfkedEl2dH14J11LVF5qpNxo1K6F
 QqIzZAt3JiB12rRMvwezD+ZVg7sFFqxcWPaKylKl80y4XxAEx9pvZ2hAQhmZOMRpb/yO
 YcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
 fh=v/vJ/skykRuXC9++upxy0QX0sjjEuXXTtDO+ZCbqXiw=;
 b=jtskgF924dmPi3dtmPaI8B/mXWb5SNQcqrBXZ0UMnwsS+gqOEekLQa6nEOozJ0/4ua
 2WbKZhmxmdNGznw95A05WwZpYoL5zPWkHulFaWDFmfL5ijJefrQtRfDD4Top4w+tBjPl
 ZfI+wqS+C+BKi5a0CElk44TBg8Gk7i31JtJI5ztM6lEwrvU2qo3nIOQKyIwEx/q5Da1A
 tln9Wsk1kRZ+F/XXcRZatR4w5XSxs6exRl4POnn5R3hf9TIiFNRN6/nK6GnX/8HKshfg
 GnKqr7P9ZKxjWZSheh+XSfnqnRV4cFndDMm/nFLYAMRT/mJ0IGz3dqR+/bLzZ6uPeZVU
 n1dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789560506; x=1790165306; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
 b=gwBwBowu4a4tXNgrjevvMgzWdp0l7I+AmwSK46agkZC87w1QqPxziVOVmniYQ1OgwH
 6lY7AxCyZ9zmd0Q2XkSR4NoiqblOVAplCOTAcyzpZsqDjKd9vm3sACX7QCPtMwnsa6r4
 xGRT8Rr1LFk0IJCoUYIqZi/qopL1ONBIL6ZiWLvKOf1ewVhqfrmcpa6SY4WaeVWXAb7W
 vCtL0kVd9oLBmWykm4pVGYfYn4iIRKVjUywJ1RMPyJaC6PIu+3ArMz0/lchsXUXQjj/4
 RmNYKIeDKtoNh44UI3faBj8KEFNgSRfuCqhDk4XgLw4h8YHDmOxos/ug9kqn2oqLW/g6
 O6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789560506; x=1790165306;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xSq8f10yAtabOXxWdIiS/nzsSXBzun+1m9a/tEIW3Hg=;
 b=sid10MrkaM1r3DAr9+g7Z3dzRbKGLi6TjOydmk7WF7UI2uU1fQJv41LZMTlQnuFkPk
 XMHvFKa2AnmaJDzDJZ4+eNAvSkAkw5r0qg3SZxAxXSvtn2HgMfas9kAMp7IiFTFl93Ta
 ZFz6x9SojeEF5i+oyNJjASOBIEB1PQGMcm7KrVK/CQQiYb1Vac+gAUShrDAC2eGU5bY7
 XA2TP5pS+4y7f89xRKrINaB1EDtyVMPKhRxlvPiVJfIlhWgaNHKjkRc1/BwyxC/krYK3
 rkidK65dDiebtbzZJDQ3vJwmG/iOf2QqSfOuM8ZsFR3m41hErVJxhEqsHABMntrjRTCI
 7fRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEKHqdgxx7ZeLvAF01J0NmY+mhYPjDWaI9dXbsnmBlLkZ6lTGSa8njtU/PbJIUdL0L+smCkeUUTKc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjpSlWTmozFmQAyhHYAhZqjnF+K529S/npV7rwJiETWUXxlkN7
 VAQ5iiaOVOKvBS7d84mspQevGJRiC2Mzp4ffEe8v9D9lhIf/mw3KUG2HHZ2QqSq6A9DyIQaFQG5
 GGQYCuxOrk02JrVujcKPUqRSbDFxYMhk=
X-Gm-Gg: AYBFou2qK4UN9r8DoNC3ndM5v94WisgO2ajGTHHcz5PO6oqeCSkXqGOLUP4Lsr1S/vW
 3+0fbyFY5eaawik7qRj3kpLvUaXUF6uZ0JrKFaJmM0p4kaGMf8AzZiTlSkNC52PruD4w2bfZlXq
 W0iulhAXKr8fu4oRKP3Yq/XMq+WXJIVtBpFqNgS0r7/6ku5dnsjBYQm9BdyvFQAICaGrQt+xTi/
 NrrXMWcMvFQMC7HVzk4Xbay4D2HPdW/7Ojmr8nKLewleeKTB8GoCn7DU0taplcQwq+XpwIMnHyO
 /X94i0KReIinr/FP17c0nMkDdHjZl/uz4OKPbuC58lMLlcnFqW+FGOge
X-Received: by 2002:a05:622a:1b19:b0:530:5ed1:561a with SMTP id
 d75a77b69052e-5327eee82f6mr43123021cf.43.1789560505709; Wed, 16 Sep 2026
 05:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260916093928.52057-1-palaomer100@gmail.com>
 <87ecet5xos.fsf@yellow.woof> <aqp4GA1q6cLKivZo@ashevche-desk.local>
In-Reply-To: <aqp4GA1q6cLKivZo@ashevche-desk.local>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 15:08:06 +0300
X-Gm-Features: AcwNN1WOW2WDT240y0ILa-CLMyO9YvF4o43EaQSFbhxhDmsrCMG7d8RZROqqgSQ
Message-ID: <CAKhZXnr0GdUrEu9vyMAWRCWyQzPM7cWQ6LRDa8fX0hnMkTN0RQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nam Cao <namcao@linutronix.de>, andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:04:01 +0000
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

On Wed, Sep 16, 2026 at 12:39:28PM +0300, Andy Shevchenko wrote:
Replace udelay() calls with usleep_range()to avoid busy-waiting and
allow thescheduler to sleep during delays.
First of all, too condensed commit message. We have as twice room on each line.

Hi Andy,

Thank you for the feedback and review. I note the line-length
formatting (~72 characters per line)
for my future commit messages.Second, do you understand the difference on what
code is doing before and after your change?
I understand that udelay() provides deterministic, busy-wait timing required for
hardware register initialization, whereas usleep_range() introduces scheduler
overhead and non-deterministic delays.
Out of technical curiosity regarding the driver IC: theoretically, if we knew
the exact window between the hardware lock/stabilization
time (min) and the internal state-machine timeout (max) from the datasheet,
would a range like usleep_range(min, max) be acceptable,
or does scheduler wake-up latency make it too risky for
timing-critical init sequences without hardware validation?
I will drop this patch series.

Best regards,
Omer
