Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BDAC5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FFA10E6FD;
	Mon, 17 Aug 2026 09:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="FYOjijEB";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F345510E6FD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786960514; x=1787565314; i=markus.elfring@web.de;
 bh=dMrfsRlJxCsuq9Jr3cLTf57fnldEu2u+fN+H3Sd3UKc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FYOjijEBwvbXZYGDUadtLyBUtEsRFE06IDhXUBArskBSYkTRKQ4V2a/EoHLC6k/F
 /cHmewQ1V+Q7JCG9lXzVu4DPFV/hLi7nwsSI/iPEOyoKtCen5idTCxxHb3g1YETYO
 fpZiq4m/77X8ad9Uo9UVmc5Q9Um0ZHqSK6QSVv5iXzXN4CiI7N/NzUbeTRG/WlRjz
 enRaqjxPEIxat0SUw8+YJ25SgZZPyNAaXAdfbPIHBjnaO6B20ypgSI370ZIoCwFZJ
 J4A7YngHyrgg+/UsSSU3+de5xmxh5RLPK/Re+KS4gKTZoU7p45yr6PfAL8tYEW9e7
 W55UsOJdgbZtUlpx1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1wac104A2p-00gAVg; Mon, 17
 Aug 2026 11:55:14 +0200
Message-ID: <eb5a74fd-8db4-4ea6-8fb0-96ade2f3566d@web.de>
Date: Mon, 17 Aug 2026 11:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
References: <20260817093142.975407-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v3] drm/rocket: Check allocations before use
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817093142.975407-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1SvbDbFW03KkJnNIeog/SX3oztyahLVh0jUwgHXAii75n6xBx9v
 cCqfU5gaHuxGWwywodpX4IPGYicQ3g34mmx4CapdEfd/v6ko3a0PulolJp9Ynwp0oRZL6if
 thyQwfOr1JgKY01/fMha6ELhxszpSW3JXReQKIkSTyjvfjbmGfPAi0boJwd9bpX3kH25Lfj
 EP9xGN7rFfQm8ynzQaJXQ==
UI-OutboundReport: notjunk:1;M01:P0:SA7wO5zI9ZY=;XrEC48mEC2V7DPWoaTGUUzyPutt
 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
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

> Check the result of kvmalloc_array() in rocket_job_push() and
> kmalloc_objs() in rocket_job_open() before using
> the allocated buffer.

* Would an other word wrap variant be nicer here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n669

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n145
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc7#n34


Regards,
Markus
