Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D76BCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DAD10E29C;
	Fri,  8 May 2026 07:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="OmJ93peD";
	dkim-atps=neutral
X-Greylist: delayed 353 seconds by postgrey-1.36 at gabe;
 Fri, 08 May 2026 07:49:17 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C748E10E29C
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1778226550; x=1778831350; i=markus.elfring@web.de;
 bh=+Os89qT9lWZoyf0ho5AZI9aaHqEOG1x9v4JqfTAOc7I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OmJ93peD1VbPkXIfHILHXxKtaUOLWixjOSiZ0v3JIDGFcJX0tw54UBEp2LSB9sWO
 4JtWKwSbb6FK4b9a9lWV9DkZKhjIaigiDaQhO77LmXqNE/TTVDlumsNxy5MIAlzP+
 EJ3iwvqO0/RPZpkf6iqyZ6AfjMHUtwgPpguaFmqBysBoJIMkmECVgyf9l5bZkh0AE
 UmfA+WueqVCaumu05Zebrc2tc5+TAHPBfYYnfoH+LcDcmkbFpJx/jxHGux773uQf2
 ksWyGHQHWpwoCNf2gbyt6BodfpSiE7dqwLQL/yO/Q0OZ13KYkMcsCGJFNF0qSwB2d
 R74tEX5fQwA2OyS+6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1vnFPr061c-00JVks; Fri, 08
 May 2026 09:43:23 +0200
Message-ID: <c565ab8a-edcd-48fe-8ae4-e788febb4208@web.de>
Date: Fri, 8 May 2026 09:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Zimmermann <tzimmermann@suse.de>, Myeonghun Pak
 <mhun512@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, David Airlie <airlied@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <da9ecab6-063f-4c29-a685-7b776234905a@suse.de>
Subject: Re: drm/bochs: Drop manual put on probe error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <da9ecab6-063f-4c29-a685-7b776234905a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/3giASq9svOJyDZkN2hAZH1lLD5yErkrMd5Hb3JAx1BuNTJ3si
 GjHq+dd3lsfwBVa/ZAGjiwdC9kFhIBqfuDvWwIhGnSCefUlh8ocEuB6o9hyhH565RIKjNdn
 S1ZpD3/CQMfgbRZU0GfWXgaA0K1SxZ8TJtus6oZeE0uUdECaVGpLC/B9oN1y+8HXnjAGhYZ
 /4r28RdJ1pTwYFsy5Updw==
UI-OutboundReport: notjunk:1;M01:P0:6EnuduEw53c=;5pwMLRLrPWDY+w+r7fzN8xBa+vv
 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
 Y6tkXaeZlPFYBj9XMMX827iA==
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

=E2=80=A6
> > Return the probe error directly and let devres own the final put.
=E2=80=A6
> Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct=20
> bochs_device")
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc2#n145

Regards,
Markus
