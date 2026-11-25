Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C75606A985
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=S5dLNZfw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67ACE10F503;
	Wed, 25 Nov 2026 06:20:12 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A896E10F503
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:20:05 +0000 (UTC)
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
 by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jZ8dm4Wsrz3swD;
 Wed, 25 Nov 2026 07:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1795587548;
 bh=wSUwk++6YId6qSiwqtkioQl0UWnsY4AI3us1MJR7O4M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S5dLNZfw5+HztpLo5e4nTGHDDApCHyO9w9T81S038DZXWKgmsDRFMTHDd4wXRo27Z
 0Ca/KgezD2b4vsYGPc59AZTSSzXn/9UUHktYYCM9cu1rU5LzCurebegY7jyJQbOT6C
 WgrEdCzRIZ+wqbg7Mz4++3HJIhcwpXeodem5tw7HGfp41vkwaMGYnqXcTuWRrlbWvm
 30ucg+yjwFIkzl3SHF45ZdHeTJs92js0R/s/3tUEqKriNwZ0yqkWwq4DDrg1KXYhMO
 XFlkyqQVRCO6PA86mK8uUmK68abvbwulHIfx2/1r1fCk9KBioDK2gWtqcxzPVfU9+X
 uyi77sDRwwn5w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4jZ8dl4blwz41fc;
 Wed, 25 Nov 2026 07:19:07 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jZ8dl5lhfz8sb7;
 Wed, 25 Nov 2026 07:19:07 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 2897B5FA05;
 Wed, 25 Nov 2026 07:19:02 +0100 (CET)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <cb74984c-86f5-4617-b05a-b812625108ba@leemhuis.info>
Date: Wed, 25 Nov 2026 07:18:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/devinit/gf100-: fix POST being skipped on
 GPUs without display
To: Francesco Magazzu <postadelmaga@gmail.com>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ilia Mirkin <imirkin@alum.mit.edu>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261124213430.9525-1-postadelmaga@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261124213430.9525-1-postadelmaga@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179558754289.1114489.3764401907754204004@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 2897B5FA05
X-NC-CID: P8SVmUqsaxEA8mK5Y7dCdnZglqUjGvChl9/TMLo0wnACFZYvfX4=
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 22:34, Francesco Magazzu wrote:
> Commit 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid
> double-running vbios scripts") skips devinit if VGA CRTC register 0x00
> or 0x1a is non-zero, unless the display engine is disabled.  It detects
> the latter from the return value of nvkm_devinit_disable(), which is
> always 0: the strapped-off engines are removed with
> nvkm_subdev_disable() instead.  So the VGA registers are always read.

thx; Dave, who applied the culprit, two days ago sent a patch that from
a quick looks does exactly the same:

https://lore.kernel.org/all/20261123-nouveau-fix-disp-v1-1-ebdc525287ce@redhat.com/

Ciao, Thorsten
> On a GM108 (GeForce 940MX: no display engine, not POSTed by the
> firmware) those reads fault and return 0x13.  devinit is skipped, the
> GPU is used uninitialised and the machine panics at boot:
> 
>   nouveau 0000:01:00.0: fifo: fault 01 [WRITE] at 00000000001a1000 engine 05 [BAR2] client 08 [HUB/HOST_CPU_NB] reason 04 [UNBOUND_INST_BLOCK] on channel -1
>   mce: CPUs not responding to MCE broadcast (may include false positives): 1,3
>   Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> 
> Check device->disp instead, once nvkm_devinit_disable() has removed the
> disabled engines, like nv50_devinit_preinit() does.
> 
> Fixes: 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5-2
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> 
> Notes:
>     v7.3.4 boots on this machine; v7.3.5, which has the stable backport
>     (992f7f5f34f8), panics.  Tested on v7.3.5: with this patch the GM108 is
>     POSTed again at probe and on runtime resume.  Not tested on a board
>     that has a display engine.
>     
>     Read at preinit on this board: 0x2240c = 0x00000000, CR00 = CR1A = 0x13,
>     0x021c04 = 0x00000001 (display strapped off).
>     
>     The regression was analysed and the patch drafted with an AI coding
>     assistant (Claude Code); I tested it on the hardware above.
> 
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> index 186e09ea0c..b256404c24 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> @@ -107,12 +107,12 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
>  	 * VBIOS multiple times may have detrimental effects.
>  	 */
>  	if (base->post) {
> -		u64 disable = nvkm_devinit_disable(base);
> +		nvkm_devinit_disable(base);
>  		/* magic to detect whether or not x86 vbios code has
>  		 * executed the devinit scripts to initialise the
>  		 * board. only works if there's a display engine.
>  		 */
> -		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
> +		if (device->disp) {
>  			if (nvkm_rdvgac(device, 0, 0x00) ||
>  			    nvkm_rdvgac(device, 0, 0x1a)) {
>  				base->post = false;
> 
> base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc

