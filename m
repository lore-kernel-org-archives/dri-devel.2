Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563ACD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A335410E106;
	Tue,  9 Jun 2026 06:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BWeuuizO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479B510E11E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:55:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9E1E601DC;
 Tue,  9 Jun 2026 06:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD561F00893;
 Tue,  9 Jun 2026 06:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988106;
 bh=DnW1gz5YxiiUXrxxdpe49dxHChbqPWtx9EdnaQYtlqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BWeuuizOLoKYv3Splci7jSjlsHfeTyuOJmx/eUqcEAOiyJkJzihLjymkUHOmqAYAu
 N1mvSeojFshvBz2q1h7p9aEIKuzR1D5oL+JPCzs3ObBEUC9qvXZvICAuy0QPzP3e0r
 RzE+SFytdJ+GEz527zsrDHfgvQ9UVo1aY866z0vHEbsgG8vijlXwNSKghGHV+syvG1
 BANjEHS2hF0Oz5UGnLhAfMynss7Q2lsIo0ut8netH8OKJfjE9Eyc36XDyNYbhhyuZl
 chfOZhfKxOIgOXj2s8ehQ9iNzckDqXO8jSqZ2S6K5i5JKuNBLfjwJ+bomroVKzXYgC
 q219Lj2kEq+LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] ASoC: dapm: Open-code widget invalidation walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609064122.95825-1-kaitao.cheng@linux.dev>
References: <20260609064122.95825-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:55:05 +0000
Message-Id: <20260609065506.4CD561F00893@smtp.kernel.org>
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
- [High] Incomplete preparation for list iterator semantics change causes D=
APM power loop to terminate prematurely.
--

commit 43f2e05998002333ccbe3a3f202cf3f76c35d1b0
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

ASoC: dapm: Open-code widget invalidation walk

This commit prepares dapm_widget_invalidate_paths() for an upcoming change
to list_for_each_entry() that will cache the next element. It open-codes the
loop to preserve the existing semantics where new widgets can be appended
during traversal.

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index d6192204e613d..5bd921fca1323 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -255,7 +255,9 @@ static __always_inline void dapm_widget_invalidate_pa=
ths(
>  	list_add_tail(&w->work_list, &list);
>  	w->endpoints[dir] =3D -1;
> =20
> -	list_for_each_entry(w, &list, work_list) {
> +	for (w =3D list_first_entry(&list, typeof(*w), work_list);
> +	     !list_entry_is_head(w, &list, work_list);
> +	     w =3D list_next_entry(w, work_list)) {

[Severity: High]
Does this open-coding also need to be applied to the loop in
dapm_power_widgets()?

dapm_power_widgets() loops over card->dapm_dirty using list_for_each_entry(=
):

sound/soc/soc-dapm.c:dapm_power_widgets() {
	...
	list_for_each_entry(w, &card->dapm_dirty, dirty) {
		dapm_power_one_widget(w, &up_list, &down_list);
	}
	...
}

Inside that loop, dapm_power_one_widget() can invoke
dapm_widget_set_peer_power(), which calls dapm_mark_dirty() to append peer
widgets to the tail of card->dapm_dirty.

If the upcoming list_for_each_entry() changes cache the next element, won't
the loop in dapm_power_widgets() terminate early and fail to process newly
dirtied widgets if they are appended while processing the current tail
element?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D13
