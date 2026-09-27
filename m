Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD0EC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BED10E5F6;
	Sun, 27 Sep 2026 13:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="l87+izXe";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE53010E5F6
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790516314; x=1791121114; i=deller@gmx.de;
 bh=6CRRQJ2V36te6T2DZhqYhYPHP648WNomge2H+AkaFt4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=l87+izXeNREF8vUmrEaPuPjM9K0LLVhckifalQbSVXTCVMn2fTSRjP/UjwfzNexD
 iyEtaPXcKAi4nOZ1dhPe1GEVA9Uee3DoBt/R4tNhNWJJvij06su9Ul0o+9LHPNS4c
 Avj1FFwmI4vm9MqGe20EHF/FfOjm3TbbkdCEk92epohAIhoCXizrqHTRK6eoeIRPd
 BKjqHbTweh5W/9FO9TezEyprxsEcIfdDFCzSD0BOOhxxRWXh/ZWbQxL9NGcWKnpim
 C/ztvXq9sYn9ucyE7w/hxLTyb7S9qLaYP8lCG9kFNcpwXZjvVVCfNR/Qg1lNHejng
 UNEDVuHY6x2apXpVvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJmF-1wOrM12N5n-00gQvI; Sun, 27
 Sep 2026 15:38:34 +0200
Message-ID: <85d17952-cb8b-438e-9e3c-7325532c36f7@gmx.de>
Date: Sun, 27 Sep 2026 15:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: name the deller/linux-fbdev for-next branch
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260927051256.2752154-1-matthias.goergens@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260927051256.2752154-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:br4P2EgotMllOJ3qiION49Rc9n9JXLnaEoPOaGxETUxaRXM6ECu
 n5v15T7l4ThTFUQMw5SWeCKDYp0YnLorbgLlz3SGB5rdLy0apa2YF1NkP8FOEL2i074vaYR
 xknnhsB78Kiu3NWgL9Ph6STLqpMfnL7H6CiBP0eXlktFr/StLKz87hjj6TyL2qUVF8+IQhZ
 vLyb09424t3HrwkuuIADg==
UI-OutboundReport: notjunk:1;M01:P0:qSOzMzKv1EQ=;neeTYVRnJ9FXF0XvvtvoUczuLYi
 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
 SDQl
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

On 9/27/26 07:12, Matthias Goergens wrote:
> The T: entry for FRAMEBUFFER LAYER names deller/linux-fbdev without a
> branch.  The repository's HEAD points to branch master, which mainline
> already contains.  linux-next merges the for-next branch of this
> repository (Next/Trees).  Name that branch in the entry.
>=20
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
> This is part of a cleanup of all T: entries whose repository HEAD is
> not where development happens: one patch per repository, sent in small
> batches.  The plan is at [1], and why it goes out in batches at [2].
>=20
> [1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goerge=
ns@gmail.com/
> [2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goerge=
ns@gmail.com/
>=20
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 140eafcbbd78..b275a2254738 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10339,7 +10339,7 @@ L:	linux-fbdev@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev=
.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev=
.git for-next

Ok for me, if this is how it should be documented.

Acked-by: Helge Deller <deller@gmx.de>

Helge
