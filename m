Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402BC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AEA10E2C9;
	Fri, 21 Aug 2026 17:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VY7+3yus";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190B110E2C9
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 17:01:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C9F5600E2;
 Fri, 21 Aug 2026 17:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1615C1F000E9;
 Fri, 21 Aug 2026 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787331674;
 bh=MOuZQE0b3k67jh8IFAGpgYdjTH5jTDtXmiUcWGfKd3Y=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=VY7+3yusO6O23frGFmZF31V+soeqnRDUfz+xGV2oHkj8ttryclH6wUKYELX96aTd/
 VgovXOASkUkCJ1yVAtwXGeQDwsVAEnUa1ENsqAcjAJlTl44ZHLblxIeZBbJOmviHSH
 mXTaccKoU8oDhHPOCLaE3zHVKpNntOa3u/KNELEZ3WQmQJ5wyV5oFBMRCRt/uaGVN9
 VnIj39Ui9YuGvn6/aEfkdPDoKoSE4uxcIQCOdzzdVVmxNnBT4iCc7XyZA/BqtGKFS2
 8YtJ22G5OEk6I6bNE+FLwgpTO4N94Q+cwWv4vGCDEetAFtz1R6iKAR+CPwu0saffHw
 an0e+6YRYy4zQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 19:01:10 +0200
Message-Id: <DKUS768JV9RM.36WFW7QI27WKK@kernel.org>
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
 <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
 <20260821155814.980146-1-work@onurozkan.dev>
 <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
In-Reply-To: <2AD43D0D-2B01-47E3-AACB-32032B3358C9@collabora.com>
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

On Fri Aug 21, 2026 at 6:39 PM CEST, Daniel Almeida wrote:
> My point is that resetting the GPU should not be a =E2=80=9Cdebug=E2=80=
=9D trace, but rather
> something that should hit dmesg unconditionally. Of all things that are
> printed on a driver, a =E2=80=9Chey the GPU is being reset because someth=
ing crashed=E2=80=9D
> is something that should always show up IMHO.

Please see my reply in [1]. If something crashed, please feel free to add a
dev_warn() or dev_err() print about the exact error condition. But please d=
o not
add dev_info() prints about things that were successful and just bloat dmes=
g.

In this specific case you want the caller of ResetHandle::schedule() to pri=
nt
about *why* the reset work was scheduled. You also already have a dev_err()
print when the GPU reset failed. So, at this point you're good already.

Additional prints about when exactly the reset work starts and when it comp=
letes
is stuff for dev_dbg().

[1] https://lore.kernel.org/all/DKUR5TGKTJT1.3VR0LSG4WWXJJ@kernel.org/
