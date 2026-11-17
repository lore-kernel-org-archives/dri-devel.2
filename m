Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE79606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkBcN455
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E604110EBC6;
	Wed, 18 Nov 2026 08:23:23 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C699610E70E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:51:37 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33fb4680717so961678eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794959497; cv=none;
 d=google.com; s=arc-20260327;
 b=fbmdGhT7NnxP3lb87IWulF4bIbc7vqvMQY37uqfLVNQFMvNxCXEOE0mpk8nfqx6wI7
 laUBTQmx33q8EBm7mYtghYrf7yFk+VFvFxggwyLg88r9XzxHIHX5ThH9lSzgJMim15Qe
 M+1X6KwAqWixlYAGh8xzweByiFbVnUgKwnLpCLMScytSHAzz8B8zKKnPoNOxSuwq54a3
 mNuNwHAIAKDZPK1wMCMJYDhJXh4As36I6+0mq4S2KPr3rBhs96IUOglNAhxHaW31gK9w
 l+0WXQesg6BinnIHVriMJ4P4cYwAZ9GvjHjhyg9YSNA7+fvnEQ3kznxIMeJBCRAa9f0R
 3HBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tj4WV4vIcKzSpCk7dHTQCpUn+mLl32o1qUnDLoMnN/M=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=q/YHEbWbBJxH3nDWLkouSOlvIdabUH+HoNtwZjBTPhPjkbK3Qwh8vRccn7Wo4MBrm5
 nZNW91RIXsFrmFxQyO/wwOB6fogR/Sa4L37XFP0ddf5CyWPx2mCPm6dBo8g9qKyGMy7B
 UU8hdfF9hCIXYtJKu3vo1o9CDRcWBYbrQsLYef9FaD1fwVCY+SZ+hCBrvWc/90tEamD4
 nSpPPm2NMncxjuJaCSvYA8187ZOjTPTP+Z1+DuRQCOWMdlD6xzSly1K+3iFHFLSWS4Ed
 itxfXuwnlmSCvVkSVqphQiQl59YUju5WZv7Y/tkqolG27GaQatQXDCjYuQNAgCa/T1oa
 s52w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794959497; x=1795564297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tj4WV4vIcKzSpCk7dHTQCpUn+mLl32o1qUnDLoMnN/M=;
 b=HkBcN4558uhycflz/7s5MOXvJFT2L4V9vkVFTFxlAVX37wEJmOJ2f7CAXu2crJOZKz
 qPa2IwmQ28kpBusKcQn9cHMxN/2bmH5or9sYelTmrdaHgvOdM/NWnyspYNCn7Pn1w96o
 OnXbMl+UUCpwC8YH+sM3o1YDdkaZxXYYDX3u8wcC5Bb5t0nqDInCCGy9dn8oaB0KRDq4
 o4+ec6fKLqHL5LH2wAvZMAXeXMkifhBu13vT75gufcTHhWeBNPf1fxgrNoRUQAV8zBCs
 jrkj8tqD3DplFcvd+iPkw/YBomDsKFu1C4xVqQ+NBkcnq0layIUnrfH5Bj3GhU7ng4w9
 t5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794959497; x=1795564297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tj4WV4vIcKzSpCk7dHTQCpUn+mLl32o1qUnDLoMnN/M=;
 b=sDkN5XQ6wfvQWfG3sXtQ/iaG2+klIDOzXfzWWsmpozo8riHQXVRWj58XHRavYPlytb
 Aiz3psQjtb9zvJFC9/hKgqWS5N13yzoLekYZ9r2dZebfqwpPVBCHlRCq0jh+ZbmNP032
 AIbvCNpbCityk/uD9N9moHpplwvfnQxO8jynpD5vO/FaBYfR7X+VpZcu6U6vKgc03kbZ
 q6NCLPrAzRITb1qpPxX0mLXTlXx7kiyfLzpDkiyIhN43UIZShONRJORYjvufaRV8stxJ
 NbWohKWQEXzXT7q02RLZgqvH93TsIzyPMX3ljloWFBBYBWmX5zQDe2HdtnLM0VB44+Dw
 mURw==
X-Gm-Message-State: APuU4Z8V1PP0vT5VOjriLEkzIrXMHAtkeKyf4wkXhmgxwEl5El37xOaa
 JA3Gxi6lALvGQUcr7N2ftJvsnzjm8DHldzfVxQiIDoYbJaf0bJLZO7ckW5OHm1ZTU4TalOzogPs
 W8o/wSakQNB2zYjIzQNAocW+RNbo2tRjmmhDs
X-Gm-Gg: AZFdTZd5NyDPL4nCzIP3ya0L0mSPoeYbIdUEP4raN57i5VNRY918vrSxPUrGXvoVoWf
 7JAOOmxHoVYBuwtUDXrjVIR3adm9u0BgASQCSlcSnG9qFfxkVp6dYqZZGxvkM+BoZ6iRluE017I
 sDT5gVE8wiK6gF8na4LGBsQiMBsNq9d1TCAUO53ZKM2Z3egQxfhAEHAX6BhF7npeAY1zWkuuAbi
 sAi7fH+KEqYBWzOkTrzhvUHp4NKMYbvssumi/3PniNRC6N5dVh7jKdJqNOTX7k4x7a77LdDEcOf
 kjSMcDmp1U1MJP/5DBR8eupZEMfQETEQzum+qWN8tubnrpTP/eNfnGxHzY/V/qv5vP51aGAC6ej
 Z77ilBAl8Y81OLR2uGqW+HEw19Ss7Th9XhY634DP99m657NUdEeuZZOaTdrdL
X-Received: by 2002:a05:693c:8946:10b0:370:1652:5ff4 with SMTP id
 5a478bee46e88-3827f5ad382mr930583eec.6.1794959497041; Tue, 17 Nov 2026
 15:51:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117205902.1293962-1-henryzhang62@gmail.com>
 <sashiko-outbox-219679@kernel.org>
In-Reply-To: <sashiko-outbox-219679@kernel.org>
From: Henry Zhang <henryzhang62@gmail.com>
Date: Tue, 17 Nov 2026 15:51:25 -0800
X-Gm-Features: Aa3M54qqTmOUkotRAt37uoUQQWDtU-BVQrOf2bvJF2uRaw79Y05rSNpAac70J38
Message-ID: <CANTW0yqbWZjvzf9pKETu5x5vAC6FtMMBLpRi11yGXg=w=so54A@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: dsi: Allocate the encoder per DRM device
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 1:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [Severity: Critical]
> This problem wasn't introduced by this patch, but does
> vc4_dsi_init_phy_clocks() just above this hunk leave a dangling OF clock
> provider behind [1] when vc4_dsi_bind() later fails or the component
> is unbound?
Thanks. This is pre-existing and independent of this patch; I sent a
  separate fix:

    [PATCH] drm/vc4: dsi: Register the PHY clock provider with devm
    https://lore.kernel.org/all/20261117234107.1298575-1-henryzhang62@gmail=
.com/

  It confirms the stale provider after unbind and after a failed bind at
  runtime; the use-after-free lookup itself was not reproduced on my
  Pi 4, since no clock lookup on the DSI node happened in the tests.
