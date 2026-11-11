Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BC606A8A4
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQlhtLxQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F1310FC53;
	Wed, 11 Nov 2026 17:04:27 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE79610F380
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:04:21 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-36e2b1db9bfso92207eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416661; cv=none;
 d=google.com; s=arc-20260327;
 b=JRFougSIAvfdnHMGrO13CL+OZFjRdMINITqw5aoZrf9d5M6/Ev/W9XO2gASEU+9mlE
 ifuc9HEALE9jcw4hgAEZp2tgoBIFyy6YbHykhjQcMsfvY+WamF/x4UtVlC2f1zF/jpN2
 o9x5IJv/pZxXNto2DFEA61G3ljI8oEjWT+6fC3c3GcnAQls1geDW8hIakxh7gCMdws3E
 zPjcgw4G9mY/xALuvCybSDJ3HtziVxjsnWrChslXr3y8De01uD2DHZYnN9q0LjiJ8lUj
 PRQGEe1OFwh1NdDWY2dcg+GUj4plF40MbxZY8NtpLKVzf40EXzGbN3+by49KGLNIT8iH
 1mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 fh=1rtAFPFbDhrz3ovVZja2aqiV01qWC3Jt4X3eT6gwWy8=;
 b=Ip5Hfq9HddAyT5e0qWaac3hhIdCyqpPYLmmXAMs2vk/Bmiob/unrwhZROHH9diVzSD
 UIGBNwK/UtrU4OA59+Yf90hh33jArTFhumRV7kfVS10ODYVjyakCFWay/mTSn4hrtgwT
 NBDOncvf7t7TdlqgyyZ1/htycqdHiONpzCoeMogYuUkwhV0wo/bYtfrhsPc89ZTIKUVk
 972vTIYgKbwycpmH3q1vzQTk9QUOlzAPaKDjXxHqkww1pNDRPNkb9FPpQ9+jNhL5astJ
 UlPUJlyIE/1wJBNwuLXZrgqbA7rxCBmqtZGyP0Ms5Pu5QZntoIdOSv63INcfWLbUt/5V
 vdsQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794416661; x=1795021461; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 b=EQlhtLxQSin6//nTzSHvKKY5YcuhW1e8fjwzw1V0FKtlTp7Eec8ryYO7lxKOxc7Dm4
 ZQ1xIUwnK6sQKlbZtoy++AjRAmwbl9vlZmWPgPN55O9qpup8rnD2+/t0KZq4Wmgqobkq
 4PvNnofqvfj771jyVHp0R/3s9b0s+POElIdmFGmtk206AEnB2ETCxbWmFjBuN2BO5z5G
 jOk4c5nCGHlPE1R3011NMH9W3lsYOlbZ0ce47tTKsZO/9K6CHIfCqpLOxR2zaEEpAe3D
 ncactd/ITkua/x0yGX1pdeRlOkdgdfkNhznYa/ITM0t0bn2n7pFpcXqgSuHdK31Nwbfw
 bm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416661; x=1795021461;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sz1fBEHUL8IGMULI0g/KGEQw0Ms9ofA5l42B+4Sj0Rc=;
 b=UPmP/fHTsKFlITgv6t+iuT7qc5Ur7d7RCV+eWnGlTGLy5BK7VwG/bsQO+mj6+0noRo
 PvTfmZiQaBnEKyBs+rUhVawzily37vprfOHKJB/spFL8QKgrw0JP/3lbthzhhsdPRFJz
 BzvG02GEZaci6R40mQ1e3C3d+WBIgsmAzqP5UjCs1N7QbjG6OC7IP7AUeCxQlxNnNl4o
 Li74wK5jZSaTp79ncT8KR+Niu+eGGqZtWHnvV5ALllgvML6S0n02bAHU/GAQLDGqbXyn
 jQKzUcFEss/4yj+Mjim5l4jnKWtbQ1kTNQL6gYNDjGdIZ405Onv5EmEEEFA/lx0FBtUk
 qfvg==
X-Forwarded-Encrypted: i=1;
 AL+hErElA/NM756DMCTEbmJ9HKi1OzELLx9Mg1Gk9rgylEZG+W6TH3b0a15LHb+zpBXtldja4fuIYbyrUUk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/WJ5gOtl2cLVrPXV8BmwULcEQVfvMFlJcV3WcNMdzEmx54sVy
 Icls6L/KchKIT5zdPV5oSDDErOC6JIuOUu5QvBA+sMmQIvXfNkFlt4IS0F0MQgx+MrTWTWqv6E+
 b4Xhix4UGucagVVFZLDie+IKdYQ0jmsM=
X-Gm-Gg: AYBFou3gkWB37TYCKBxwpT2OFInPcwmbsz8Cjvd+XGscB3TLtt+pbKzMm/UuejgVIsl
 k3EOfoCa8TtK6coIxO7Me+TiYO3uUU7G6gppyQ/1lFutGJd1+lHY7O28hGZWK67Gj89UnJd9yf6
 7/mACcpbqldfBXMw5gDHxEiU5CTaD1mpS+AzFLNfF4qqCRsVQBAdFAz7FqyJlxuoRbGQ/mfriY7
 yzvEGOzQ+rc8EOjv/PyFrVL+rBN8n3u9GbZ6JdAjuKuCSGzTP/9hPyzSf4otLGSjMwwO+PwvTdg
 h/G1Y0IrAkwUa0oD9YQv+MeXNLGv73pCLYJCHK0r9RJYlo5wjQrvGLk3ofMMceJXehuNppbofTH
 8FSo597X66Ay0a1enqAKZ1aokxki55Ix5RBXKJ0+17/OW9eavAIZ0t6oPQFFt0dhfNU+MHj6+h7
 eckNk8qF6usZ2r8EsTh9z5kuYY/WmJsEfer0IM9nIqEB8M1ABoQ5wUHCD8KJk=
X-Received: by 2002:a05:701b:450c:20b0:17f:641e:7f6b with SMTP id
 a92af1059eb24-1b3c02cf135mr4314767c88.1.1794416660805; Wed, 11 Nov 2026
 09:04:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-smu8-sclk-fix-v1-1-47c6c0c8c2c9@etsu.edu>
In-Reply-To: <20261109-smu8-sclk-fix-v1-1-47c6c0c8c2c9@etsu.edu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:04:09 -0500
X-Gm-Features: AclHuK-qUsJmbGMoQgyzTNraWEn4fQl-1Spvcdq8IIpAnzBeguVmCP2_i5NrNHY
Message-ID: <CADnq5_OQfN6fqdW8OzhPAE=iOmy7OtH9VV=6-dxfwT5=R39OPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: send smu8 sclk level indices,
 not the level mask
To: hornejd@etsu.edu
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Eric Huang <JinHuiEric.Huang@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Reviewed and applied.  Thanks!

Alex

On Mon, Nov 9, 2026 at 9:21=E2=80=AFPM Joshua Horne via B4 Relay
<devnull+hornejd.etsu.edu@kernel.org> wrote:
>
> From: Joshua Horne <hornejd@etsu.edu>
>
> smu8_force_clock_level() passes the pp_dpm_sclk level mask straight to
> PPSMC_MSG_SetSclkSoftMin and PPSMC_MSG_SetSclkSoftMax, which take a
> level index, as the other smu8 callers do through smu8_get_sclk_level().
> In manual mode, "echo 0 > pp_dpm_sclk" thus selects level 1, "echo 2"
> selects level 4, and masks above the highest level index are out of
> range for the SMU, so e.g. "echo 3", "echo 7" or "echo 0 1 2 3 4 5 6 7"
> do not select the requested levels. The original single level version
> sent 1 << level and had the same problem.
>
> Send the lowest and highest level in the mask, as smu10 does, and reject
> levels above those the SMU has enabled, as smu10 and vega20 do.
>
> Fixes: d7341ef66870 ("drm/amd/powerplay: add some hwmgr functions for sys=
fs interface on Carrizo")
> Signed-off-by: Joshua Horne <hornejd@etsu.edu>
> ---
> I found this while working on overdrive support for Carrizo/Stoney on my
> laptop (ASUS X555DA, A10-8700P); that series will follow separately.
>
> Tested on that laptop, 7.3.1 with this patch applied to amdgpu. In manual
> mode:
> - "echo N > pp_dpm_sclk" for each N from 0 to 7 moves the current level
>   marker to N
> - under GPU load, "echo 2 3 4 5" keeps the clock between levels 2 and 5,
>   and "echo 0 1 2 3 4 5 6 7" lets it reach level 7 again
> - "echo 8" and "echo 0 8" fail with -EINVAL and leave the level unchanged
> Without the patch, "echo 0" selected level 1, "echo 3" and "echo 7" did n=
ot
> select the requested level, and "echo 8" was accepted.
> On amd-staging-drm-next the patch applies unchanged and builds without ne=
w
> warnings with W=3D1, sparse and smatch.
>
> I used an AI coding assistant (Claude Code) while working on this. It
> found the bug, wrote the change and a draft of the changelog, and wrote
> and ran the build checks and test scripts. I reviewed the change and the
> changelog, ran the tests on my hardware, and I am responsible for the
> patch.
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 8f82d7c07e8c..5a3f697a37a2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1483,15 +1483,25 @@ static int smu8_store_cc6_data(struct pp_hwmgr *h=
wmgr, uint32_t separation_time,
>  static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, uint32_t mask)
>  {
> +       struct phm_clock_voltage_dependency_table *table =3D
> +                               hwmgr->dyn_state.vddc_dependency_on_sclk;
> +       uint32_t low, high;
> +
>         switch (type) {
>         case PP_SCLK:
> +               /* the SMU takes level indices, not a mask of levels */
> +               low =3D mask ? (ffs(mask) - 1) : 0;
> +               high =3D mask ? (fls(mask) - 1) : 0;
> +               if (high >=3D min(table->count, smu8_get_max_sclk_level(h=
wmgr)))
> +                       return -EINVAL;
> +
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_SetSclkSoftMin,
> -                               mask,
> +                               low,
>                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                 PPSMC_MSG_SetSclkSoftMax,
> -                               mask,
> +                               high,
>                                 NULL);
>                 break;
>         default:
>
> ---
> base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
> change-id: 20261109-smu8-sclk-fix-2eacba2cbfc0
>
>
