Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164B1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71FF210E371;
	Fri, 26 Jun 2026 08:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZ6wUmHl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19A310E371
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:21:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10609600AE;
 Fri, 26 Jun 2026 08:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A601F000E9;
 Fri, 26 Jun 2026 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782462099;
 bh=/URyDSaM1Mp00hYDxzcu1PlaeGQCy7y9ufaCKG+1pYk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=dZ6wUmHlou3J6WeaopCIhZOzl5LxPzE65VLGwts7XKUdv71sYAo7u0DcmzHudoAeC
 dUUU3ZBCDSL1NXw420mqK9HQKDWL+3Mf932mHOQbY5haEiBgbzgz+TvikEdOG8odvD
 b1xMWbiwWliWZPzhGeLA+1YDYFPXwVtjUHD231hpuDUDCdBWWpz8fTMT2aNKlNClA0
 auSTv8t3dvuaYganHC6zeXelxXxD1hJBswndcayL5cTEfGWd7sDNN5UuosA5B5UhWE
 0iB4C44h6WSBaWEu/jEws2dH0VFYZi9QvILF/Ez8Hd6jBU8RVZlmVkL2yPhIEpb/tG
 Z7rdZkOnXcovw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19B8839389E8; Fri, 26 Jun 2026 08:21:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v13 0/4] kunit: Add support for suppressing warning
 backtraces
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <178246208674.3816447.9584369939582811196.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:26 +0000
References: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de, brendan.higgins@linux.dev, 
 david@davidgow.net, raemoar63@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org, acarmina@redhat.com,
 linux@roeck-us.net, kees@kernel.org, lkft@linaro.org, mcanal@igalia.com,
 error27@gmail.com, simona.vetter@ffwll.ch
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

Hello:

This series was applied to riscv/linux.git (fixes)
by Shuah Khan <skhan@linuxfoundation.org>:

On Fri, 15 May 2026 14:29:31 +0200 you wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons:
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
> 
> [...]

Here is the summary with links:
  - [v13,1/4] bug/kunit: Core support for suppressing warning backtraces
    (no matching commit)
  - [v13,2/4] kunit: Add backtrace suppression self-tests
    (no matching commit)
  - [v13,3/4] drm: Suppress intentional warning backtraces in scaling unit tests
    (no matching commit)
  - [v13,4/4] kunit: Add documentation for warning backtrace suppression API
    https://git.kernel.org/riscv/c/5c1553dd5db3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


