Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NkpujxrM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B6D10E02E;
	Mon, 16 Nov 2026 01:20:17 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D116910E02E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 01:20:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE91310ECE5; Mon, 16 Nov 2026 02:20:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794792009;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=dWm0RA0tqTSQdhSoSRmxYRJkKHnJc3RlGD6s85ZFy6o=;
 b=NkpujxrMWHvpHm5fXyGZ4jZJd6IkJyOnFtBYv9hthQrvQQH+xPgGUzZUg/z36bh7FsdTtw
 Q/FogVUucUP8XnscyICVSkneDDNsUFVM65R9JkeLI3pepRHkYK2JlaUx+pOgbheXE+xhXx
 9oFqbVd7YqXzen7fzurK37eRhYYM3UjPFHX72E1SBswuqvuZcXmdtyXSv2FNi0JKimnLfu
 Di/8uZxX+JYTmzq/Fqfcv4Hmdxci3dilZLpLYqz8rz0Dw1dmVpzmKjtHo4pe64AfuybM30
 HCYtj/u+IG5vuGjfWc6EC9ZtD2WOSunsfyFW5xeGd+Ch5dYa7x85tADcCAHsYA==
Message-ID: <293083d1-1085-40a7-9d6d-1776ed649238@nabladev.com>
Date: Sat, 14 Nov 2026 17:37:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nouveau: pci: quiesce GPU on shutdown"
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 dri-devel@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Li Chen <me@linux.beauty>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Ole Carlsen <ole.carlsen@tutamail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
References: <20261025213027.842978-1-marex@nabladev.com>
 <aviIPk4xbKhgqcTy@monoceros>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aviIPk4xbKhgqcTy@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 5:20 PM, Uwe Kleine-König wrote:

[...]

>> -static void
>> -nouveau_drm_shutdown(struct pci_dev *pdev)
>> -{
>> -	struct nouveau_drm *drm = pci_get_drvdata(pdev);
>> -	int ret;
>> -
>> -	if (!drm)
>> -		return;
>> -
>> -	if (drm->dev->switch_power_state == DRM_SWITCH_POWER_OFF ||
>> -	    drm->dev->switch_power_state == DRM_SWITCH_POWER_DYNAMIC_OFF)
>> -		return;
>> -
>> -	ret = nouveau_do_suspend(drm, false);
>> -	if (ret)
>> -		NV_ERROR(drm, "shutdown suspend failed with: %d\n", ret);
>> -
>> -	pci_save_state(pdev);
>> -	pci_disable_device(pdev);
>> -	pci_set_power_state(pdev, PCI_D3hot);
>> -	/*
>> -	 *  This is just to give the pci power transition time to settle
>> -	 *  before an immediate kexec jump. it’s mirroring the existing
>> -	 *  nouveau_pmops_suspend() behavior, which already does
>> -	 *  udelay(200) right after pci_set_power_state(..., pci_d3hot). In
>> -	 *  ->shutdown() we’re allowed to sleep, so I used usleep_range()
>> -	 *  instead of a busy-wait udelay().
>> -	 */
>> -	usleep_range(200, 400);
>> -}
>> -
> 
> I cannot reproduce it

I can surely reproduce it, because since Linux 7.1 I cannot shut down my 
computer, something which worked since the beginning.

> , but maybe it's helpful to find out where/how the
> driver hangs. Adding printks might be enough, and if not, remove stuff
> from nouveau_drm_shutdown() until it works.

The laptop screen goes off, the machine is unresponsive this late during 
shutdown, so adding printks() does not help.

> I'd guess this gives the
> needed insights to determine a fix without reverting the identified
> commit.
The problematic commit should be reverted and reworked, since it breaks 
existing users. I am open to testing patches on that machine.
