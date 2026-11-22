Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D2606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1mjpdtN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4F910E1AD;
	Sun, 22 Nov 2026 07:15:54 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C1210E1AD
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:15:48 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-380b40312e2so5227531eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 23:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795331747; cv=none;
 d=google.com; s=arc-20260327;
 b=BbTRyO84rb0C3OSoUpbbk7L7DlKnH5idA8UrB5mxMONO9TPeaxaFnEa7yKpbuMDKxg
 GUPxynl4sUWnjbbhHFmh3yMiC5rlq0WTPmhkS66Thwj23oGLiK+GPdPdsLfYvo32uqQh
 dtLJ2Z/CzSB9FyDd/bBtM6eIHpU2wcdlY99g63kplEnQnKSoyoqFkeLf3Uk9wQM7AHZ1
 A6SnihrgjnzaG3fEpjNf3iQILgEI200mn10/A4v7EXFfIZvVnHEr61T1Awnl87uZbv62
 par9SveO6DkIuM0JbBsonn2nRVGkCCa5zqwGXgj4YHrejm3Amjp070jL6KvuDLBkz+Cc
 1/sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l9vVVtNKbsfO1loptCZ6tnTCDjeM/wB8BwK7TcAw3O8=;
 fh=hX4JPlUEeawxX7Ml+3lFkA5ZlFT/SreEAbi1xBsURw4=;
 b=RP6Vr0cTlbh+43xcdhAW1eW5jud0C0nUwOqow6nEWDmgNTOjjq1YlNBfQICeW4hQSe
 aCfwADVRdjyLw7q7UbVh2pIuXQ50kPDKVLuV6gl+1XbPxYUfp0rmmatZ12q4iKz3vUFS
 BlKQcVHBuicLA1f8Rx1EeFbYBSRNR82OG8TJTZeyl0ddgUOBMJD0SzO5G7LVC0U+P9U6
 HHQ55jTQQG4OrJDIYrlJHl6WG9cfkt9YzpkodB6q/XAlhU1rYj6L6vlSHKTmMYJ/kydm
 PmIfWxvE9KHeYY/PqT2uxTq0siuMNxIwBXJgB7QFixc4644bJf1iIbig/0EZcX9TNKVx
 fopA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795331747; x=1795936547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l9vVVtNKbsfO1loptCZ6tnTCDjeM/wB8BwK7TcAw3O8=;
 b=V1mjpdtNvna9OaODwpc+6f8h+uPhtiSbyCd0zpUny5U0HGcsbAJjD831ZzbAa06Fgq
 PefxO87GSWOZVYX4q7SXEO31YJl5EeO6wucPecLiBz3C43ogcf4ut5fDYOhxo6lwsjpY
 K7LU1asT1BQpTU2xVTFn9SD9NUvVS/DmBr5L+D17iMlNAGTvWwtySPNib+VjAGuIBdhk
 JLq1rKsCCOWltvbduFOU0aJiJ/bUDts2l1UAg8aBjFs/qdC8zey9Puz34/WoeZyMAk/p
 Jx2PxnZ8HAHoPP7t9zRKDtZ7fwIdjY0pXnDuK+rzKxF//d6uo4OSLDRc7/dV6lg93kC9
 6sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795331747; x=1795936547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l9vVVtNKbsfO1loptCZ6tnTCDjeM/wB8BwK7TcAw3O8=;
 b=FyHYS5ZofYJiFtlXAK4bMz/wtl9LzuFypAX4p2qD/oyvWoNWN7N2Uvr06DdX0Unj4F
 ZdKDz2Xd7RiBhef3yyrHj+IsnHZZY2d6H9ohHM/4Klasa0klnhQJSvuBAede73wleEJW
 yYk72uu1jR71H/8rh3BabJGs8hbAaWpM2xQfa3gzTVr6Wqqe7qvRUXwIDEUYt1wdWm78
 neMRDa22Ed8s8YiO6iDM4wVrYPOo+gGC7rYVEdt1o9MHSY2mcbcROtPvajGE+zA2vohk
 ypzDaLibJG8K40z5uaj8fKNv1Y2Siz4JbrURwNDO8iZGF/IVj9TGPi73zPel89ruuFQZ
 O/sA==
X-Forwarded-Encrypted: i=1;
 AL+hErGhp+bcId6cFr8FINWGv9GeFR/51DziQUvX1iYqCAYuH1Mh58Rgow21v/3otFBpXXNFxvhL2FDditI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9O2wPr+NErhfGmqcmH22PxAe2WFnapZtlwPTOdE6nARQk3jMpR
 4KNNP5gZZa75ff/8E06lXJXHQgHJMA7xsTj3rwtQd3KADRGG96tmc/NMUyPcttgJdtjhfxEaEXu
 y/uMQCQo/NXl7lmC4eaEuto8tHQlxPpM=
X-Gm-Gg: AZFdTZd9hpYc0mUz1PuFYZ4n1fKKNHJUCjzIOh4xr0RGl8IdAN/hdAa+vPdxc3mApd7
 E5YxoYvjhuacdV62Hbx2OCZ++4snAeUINXLFDu0q0Ifd8sh5g+QzNEjRGGBI4g72xkzr8/2WDGF
 Lma0q/wfcNki1bogkKYbw2cHtKuRQTK5FOvUhlLw8nsIMz2pbe4qSeRLHuD+aMHXacGjOW+UmI7
 RDJBQTdEbn4ovJ+0DLAVUAKIDAHgjlgF9U3aOrYVIliakr0WlAmmckIOKx92fP4jOREjIPMLSbC
 9OWI1CPgfbyacndQxguekAFgV1JWU+DXacq5XJ/nwspkOOsaWsonwGKLEC7ckTS6Vw5xewxuTJv
 0CEviIdaAxY/m+D2uDepkivOWXCld6zCVVgQwpXF9dOxHwHnMk6+fjYJFNM8Bf0UO/XDlpZeGn4
 Vsqj8IGpU0JIseedKZnfmslMICCQgL3w==
X-Received: by 2002:a05:7301:160e:b0:384:c1bd:aa5d with SMTP id
 5a478bee46e88-386a87f00a6mr1177313eec.30.1795331747418; Sat, 21 Nov 2026
 23:15:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122-b4-host1x-mipi-clk-leak-v1-1-c14ac933945a@enser.io>
In-Reply-To: <20261122-b4-host1x-mipi-clk-leak-v1-1-c14ac933945a@enser.io>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 22 Nov 2026 09:15:36 +0200
X-Gm-Features: Aa3M54qHH4yO8CRWw6s4odlh_SwLNi-dJlAJG3IGVZ6eeuCgoP84FoSy-vDiSHQ
Message-ID: <CAPVz0n2GVmhrR7nuNLrX5n_1Ka4_r0D2kZ3dYxNHjTiQAnzanw@mail.gmail.com>
Subject: Re: [PATCH] gpu: host1x: mipi: Disable the clock
 tegra114_mipi_power_down() enables
To: emcp@enser.io
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BD=D0=B4, 22 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 07:1=
2 EMCP333 via B4 Relay
<devnull+emcp.enser.io@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: EMCP333 <emcp@enser.io>
>
> tegra114_mipi_power_down() enables the MIPI calibration clock to write
> the bias pad registers and never disables it. tegra114_mipi_power_up()
> pairs the same clk_enable() with a clk_disable(). Every DSI power-down
> (each DPMS off, each suspend) therefore leaves one more enable behind,
> and the clock never gates again.
>
> On a Tegra Note 7 (Tegra114) the mipi-cal enable count is 0 at boot and
> 4 after four DPMS-offs, with the clock still running while the display
> is off.
>
> No register access follows the new clk_disable(), and every other access
> in this driver takes the clock itself, so nothing depends on the leaked
> enable.
>
> Tested on that board: the mipi-cal enable count stays at 0 across three
> DSI power-down/power-up cycles.
>
> The code and this changelog were prepared with the help of an AI coding
> assistant. The submitter has reviewed both and takes responsibility for
> them.
>
> Fixes: 15372d4be7f0 ("gpu: host1x: mipi: Power down regulators when unuse=
d")
> Signed-off-by: EMCP333 <emcp@enser.io>
> ---
>  drivers/gpu/host1x/tegra114-mipi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegr=
a114-mipi.c
> index 49ed05d1a6..06130d453b 100644
> --- a/drivers/gpu/host1x/tegra114-mipi.c
> +++ b/drivers/gpu/host1x/tegra114-mipi.c
> @@ -197,6 +197,8 @@ static int tegra114_mipi_power_down(struct tegra_mipi=
 *mipi)
>         value |=3D MIPI_CAL_BIAS_PAD_PDVCLAMP;
>         tegra_mipi_writel(mipi, value, MIPI_CAL_BIAS_PAD_CFG0);
>
> +       clk_disable(mipi->clk);
> +
>         return 0;
>  }
>
>
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261122-b4-host1x-mipi-clk-leak-ebf2c34b1640
>
> Best regards,
> --
> EMCP333 <emcp@enser.io>
>
>

NAK

I wonder if this is AI slopped, or straight up stolen? Or maybe both?

Existing patch sent 25th of Oct 2026:
https://lore.kernel.org/lkml/20261025-upstream-host1x-mipi-clk-v1-1-6bc6e75=
5b4cb@tsv-stahl-riesa.de/

Reviewed by me and Mikko.
