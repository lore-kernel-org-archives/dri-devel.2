Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qiqAD0XI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D764A10FFB1;
	Wed, 18 Nov 2026 19:19:29 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9705E10FFB1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:19:23 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795029562; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:NITniuV942gf8rbeUxYtW7P5Mxny
 KQY9ScmQ4hQxGE24+OAvj5XF708hyDcYNdBb3AYoqRMnekEPPAFiOJqdWtpD2terZxCa8abRvEj
 02G5IuTSppSFZmyTa0GqWg3LzA/nYwQPkyJ3TAOlUA4vCrCoCs0HUYBhh2y6SgdHO1GiBJE4wPz
 56QvgI/qcg2lCdS0zLZRwY4M7RZvKwt2V8oPenlT3ZysCTw0NanfhvFpnsRwKG/jj3Vc46+Be2N
 GzFskfjbMAZa4Od2DiLjPXDNMsrjtRGL0o3B0jMQZR/x2/D6ISZsIG/bN8faII60AKWa4DXfh+o
 DlB8sk4Byp1vEA==;
Message-Instance: m=1; h=sha256: GOZCEb1dZfQ04fOTM2mId8ErWINtSj77dsn/cdIk8g8=:
 N8zy4yt1Jlnj/ho1CuBf7IG4WX26uOj9ad7VuF+cfkI=, sha512:
 UJoCFXF4a0+4oz0yHOE4QAgyBWl6RLQBPTldi88SGHxGfY0WjMKkvHIGTYDyCHsR+aOkgPhW0PAWsQwCDyTb7w==:
 4OFuwBaiiRFLdxXcjj4ayeJzz55iSGvfuW7NaJ7Eok8aBBlEVYrr5g+RKoo3MhnqweWyfSuA3iQ6JFTWgcAKSA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795029562; x=1795634362; i=deller@gmx.de;
 bh=pc7g3WC4BYe4x291n/AR3A60XIByGkjtz4cqxRT34aU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qiqAD0XI+GJ6aeKfAh/yEG0rR1PpNd0lcFt0PbsmrPfhGTYy60R7b+UIJBiqxELV
 VsmMPfQbQZyIPjN2rmLWIOtd4FQxaTm/NfEjD5in/v6Dw38VT9OUuQSFEhnMHNHNr
 9i8Ln3Bb6o7AL+YbFcHpvSHXhsPpxpPtBeWFv84a13SQV58zTTswD6g0X1J61rFlW
 qk12CsX7W9XkK1/+JqdJSlslE2vXd5aPmnI6BuWtciVizuWdDmlEDHFe3l9hHRUuq
 n8yb6SKExxEPXuVDTZcDeGDAmk+gLkLtKu7bEzrHQNlxil3BHRgRnRDEC5PjqyFtU
 VIHxWCY0wV6nZPYi8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1wVrIh07Nh-00sQck; Wed, 18
 Nov 2026 20:19:22 +0100
Message-ID: <633ab4d8-fb7f-435b-9052-fd0a51bfb47f@gmx.de>
Date: Wed, 18 Nov 2026 20:19:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
To: Zou Jianqiang <jq.zou@outlook.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "byu@xidian.edu.cn" <byu@xidian.edu.cn>,
 "25181214217@stu.xidian.edu.cn" <25181214217@stu.xidian.edu.cn>,
 ONE Zeroiser <zeroisere@outlook.com>
References: <20261101104107.33909-1-jq.zou@outlook.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20261101104107.33909-1-jq.zou@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8l0VICtKPh/D3Ja5DI1pKeGhT/aEtvMNHF3GV4zCweHZDYowllD
 pCl8SxkzdSAzAqIG/mOY4uXJtBicmg8TWf8frYfPoJvS49aq0/hC/2xrGtYRA8Ae+247tbI
 LjjmQvIPnP5yY1/l8L8HYv+zvQAZnMj6KKRejbPp/+pGesAjzpSBYTE5o49oL9zwgUEGeoW
 fUvpgWrj1sV6HMHYiGGFA==
UI-OutboundReport: notjunk:1;M01:P0:W6fwUkbMUxw=;suieIM+0y5KN5cCMlkHwgt6TSfO
 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
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 11:41, Zou Jianqiang wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
>=20
> radeonfb_set_par() derives the dot clock from the user supplied
> struct fb_var_screeninfo:
>=20
> 	dotClock =3D 1000000000 / pixClock;
>=20
> where pixClock is copied from mode->pixclock.  A zero pixclock
> bypasses the existing validation and makes the kernel divide by zero
> in radeonfb_set_par().
>=20
> The driver does have a check for this: fb_validate_mode() returns
> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
> the output has no scaler and an EDID-derived mode database is
> available:
>=20
> 	if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)
> 		if (fb_validate_mode(...))
> 			return -EINVAL;
>=20
> mon1_modedb is only filled in when an EDID is read, so when no
> EDID-derived mode database is available the validation is skipped and
> the invalid mode reaches radeonfb_set_par().
>=20
> Reject a zero pixclock in radeonfb_check_var() before matching the
> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
> ->fb_set_par(), so the invalid value is rejected before the mode is
> applied.  This is the same check other fbdev drivers use (i740fb,
> arkfb, s3fb).
>=20
> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
> single FBIOPUT_VSCREENINFO with pixclock =3D 0 is enough to trigger the
> divide error.
>=20
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> ---
>   drivers/video/fbdev/aty/radeon_base.c | 3 +++
>   1 file changed, 3 insertions(+)
applied.

Thanks!
Helge
