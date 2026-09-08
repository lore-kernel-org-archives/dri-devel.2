Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DA2C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BB110E9A6;
	Tue,  8 Sep 2026 04:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="Q6BiCJay";
	dkim-atps=neutral
X-Greylist: delayed 532 seconds by postgrey-1.36 at gabe;
 Tue, 08 Sep 2026 04:43:00 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B2E10E9A6;
 Tue,  8 Sep 2026 04:43:00 +0000 (UTC)
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
 by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hfB045B4Tz4829;
 Tue,  8 Sep 2026 06:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1788842020;
 bh=RM2uDjlFoSwaGz1ZGrnrQMAsuHPyc1eT3wom3p+9gY4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q6BiCJayzYz6GjTSA2Dl8fdAucdaLi+G1TnvA83i/G4XOpecCGlYOF3m2FTY9qvW7
 PnRLZeJ9nSfceueOj9zyN5b5yEw5Migl07zQJqKj1GRARpF61/7KB0CdJd/jYShGTm
 Z/NLuXHcAFA4YKNSb9o3ziC+2CuUohSJJ+3z8fr4fu6ArgIe99UlU2L27cFPLZHSQN
 mc71aqGH0YDJitkLJE9Bzn3IxNcYhWlEk3NwlKnzyIX6o9dNIFdmiS2QWOObFFJXgE
 2dQPCirqJvrDVluRVVXMslRq18XtlGPHREIEfxJ3a8Pf/gLtQ31dwPOEBwQZn5fumv
 8/6nIRfgpIiOQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hfB044TD9z4825;
 Tue,  8 Sep 2026 06:33:40 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hfB035dhHz8sZP;
 Tue,  8 Sep 2026 06:33:39 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id D879A5F9CD;
 Tue,  8 Sep 2026 06:33:34 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=linux@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d408716c-7af3-4f29-a796-cda595befb98@leemhuis.info>
Date: Tue, 8 Sep 2026 06:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
To: Klara Modin <klarasmodin@gmail.com>, Manuel Ebner <manuelebner@mailbox.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com,
 Mukul Joshi <mukul.joshi@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Mark Brown <broonie@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
 <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178884201540.1018164.10882620288814615527@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D879A5F9CD
X-NC-CID: OfPuqa33tXIzRDlFuj7qC37NDFfZmiRRCGlOBkBPRqdvFQtbZiw=
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

On 9/6/26 00:25, Klara Modin wrote:
> On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
>> On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
>>> On 8/31/26 20:33, Alex Deucher wrote:
>>>> From: Mukul Joshi <mukul.joshi@amd.com>
>
>>>>> error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
>>>>>    --> rust/kernel/drm/gem/mod.rs:265:58
>>>>>     |
>>>>> 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
>>>>>     |                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
>>>>>
>>>>> error: aborting due to 1 previous error
>>>>>
>>>>> For more information about this error, try `rustc --explain E0063`.
>>>>> make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
>>>>> make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442: prepare] Error 2
>>>>> make: *** [Makefile:256: __sub-make] Error 2
>>> Full log:
>>> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
>>>
>>> Reverting this change and 2/3 from this set fixed the problem for me.
> 
> That leaves only the documentation without the feature so might as well
> drop 3/3 too in that case?

My intention was just to confirm that these patches are the problem, not
suggest this as a solution, so I didn't bother about the docs. :-D
> Otherwise, the following also fixes it for me:

Thx, for me, too.

Ciao, Thorsten
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e1ebad77ebe2..847e0ee38863 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,
>      };
>  
>      /// Returns the `Device` that owns this GEM object.
