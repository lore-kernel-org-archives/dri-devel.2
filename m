Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E23CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 23:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D0410E434;
	Wed, 20 May 2026 23:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WnTJZ59T";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909CD10E434
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:37:34 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8b74b460d77so71167216d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779320253; cv=none;
 d=google.com; s=arc-20240605;
 b=Dt3MylmwGZVi6mxBSQHJXE2mkivZt5QQXqrMicTrj+5FY363SQfaeGm7wZT3HEc4/I
 tG9XCxBEq8alwpCfxJY4v2HydBPwZ7C4S4tu/qxZmeeMwqAx9w/6CYq/FEXvE1drnN1h
 SeidgijnlSyHsdyuugS7NJEGnuAFrBMvAtM2GVYMMMORLl1UGqZt069aeF6dZ7Uj8ebB
 ZuFH2l4LRba9iuXHikfuSXOWfSv7lBlBaG9HFUkgqevXU9f1V2d9HeOX1/JYJa2DCPuC
 A71V/BfHWwzN43+F2F6zUFCJmFpw6wVU18J9DmFfciUKfwY1OsXsbd4Uh94H/szC2RH2
 wSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sp6SIKeuA2uB6yGcJDbhDcgvTpERKEz2fYzJCywaX1U=;
 fh=P+BOdEQr09lbY+JcSV33bdOg94/tK36ypxNHveRDYKw=;
 b=cIkjy5xS16cZSFDv+EiuT4vS/IucZdIuDQLN8tluSBk4Ft4kW39gbmeEFx20h4fi7l
 izKefviKls22At/f6bJSWXiZk5Pqp2bXw9wZHdL5c8ZBoloq8hnwVIKfPxEAIob3VwKm
 j1+eCbc7cdGIUezD7kvsGwKNksJzYU6jt+rTtrNcsT7oE/Te9hVuSv4XFLHjPhUAN2hV
 nbGvosxrbFJ1genUUnQFO1vyBkeDofbYwdSREZeAwb/X4tgleSX/iLV/GzA6PwtVBXNw
 IVs3NWKkDxP7Heei07qcwtGKd31eZPAqyxI9+EDkGES5+w6/ti/CbEurnAjaOI00zonA
 uloQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779320253; x=1779925053; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sp6SIKeuA2uB6yGcJDbhDcgvTpERKEz2fYzJCywaX1U=;
 b=WnTJZ59T0O7ODnO4gk64Izk/gXA7KMHXmw2r42BtAWOE5kUJYb1d3j9TN7+a50w3iO
 vERbzJ3FEXgZ9yYhYmwlY61chDrlFh0rMOKfx30K69qXbTlvl+LVtIGyCL6o9lEfM+m3
 bzlruLvACLsXVV5kWbYrh+PBLfHhtxI6JLoFiPm/SAg4mRnAbGyLjXW+J+bri5MkvM38
 BnwXlZWLFVYIJaK2BcV53LqRHe5lNUvJmuizNLl9HeI2Ni7ysr4ooAIQ1alUW7y9BmlB
 5bJ36lP/XmB83uhZPN9b4HDsm0v0mDeOYd6m1hqECiAtAknvi6c+Eh+0OUyQOjx1j1sk
 Gynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779320253; x=1779925053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sp6SIKeuA2uB6yGcJDbhDcgvTpERKEz2fYzJCywaX1U=;
 b=XfJvnF+PD8G9wvnfjeg4GkjGLz1shE4/5R2i722DQupTn3snUDcjrEm4m3sm5r8CIB
 cn6PE7IA8CE9TQROKP8Qjv1AhjOLb7j2Dg7AW1+cb9rYXzV22eWdxuf9GEKDo0x7uKb/
 vaEqvDlFX/xdCSeQ69bHqG++jdMKMfUL+1KG7lgQGgG5Y6r4DGXDQzUtrKD/4EUfsVpE
 TlGb23cz/flzq95GPbqdf7z0TGnzPqLFIEniLn6UfAnoVlTsXH8e55ggiMRF96vmZeJO
 15TjiU77nlEtZHtegZNs/jCoZK64DgzmRVQP9BgNA1qY8XEjcldEHnqoeqLI79yQzP2A
 aq7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BArsRwpQoI1/comytFfVLbcA48Ml9llUM6IZ57vBB5OU6Osw3wm6oQBb5U/LFyV7j/hWGUfptAdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu9/jjfTTH4sLITe6JUggkrbGfdS5kFYOSTk0Ajw+MkDCWeaFz
 BvhYzfw21H831JvF8YAP79XtX8p3xxHzNj7r+KIVhuZXHF7/3NktgEMQKpRfqxliHycliu6kr1h
 kr7SWr/kBQLnCD/dbtPlcJhW+28xj0us=
X-Gm-Gg: Acq92OEjIR0ehpCA7xUmy6T4vLjBZXht1g3t3P3Qiaq77/YWgHtrVLONUZn4ogAZuvT
 pf+IAIKl83DsYa9tCBKLwpAlrrmbUgZX/EoXpbkkrgze9mdTBbA03jxnOj85AcK5Fqss8KmiOzK
 KTTxPSKzI2BCiyBSku4tiUlYa4TCuvWTWHJAJvE5RKiBDopqDmieuAVI/jBlDrbkWzSDO3ChwEV
 SOdWbPgnNwyG4D5qchSkpKkV+eFCxgXUmi8sFcCjMFMignbwJfJZHGI2JoTJaXAR7yvKl9lrYES
 HoBVsaUQDTcO8cJlh4bWK8zRQiVtCqyN5+eFuRF5zQk6m4IYITIdKwJo9xCLjjnUwnw/r2Da4/Z
 0ottQ840/C/IF
X-Received: by 2002:a05:6214:c26:b0:899:f24d:1245 with SMTP id
 6a1803df08f44-8cc6e67627emr9539666d6.43.1779320253600; Wed, 20 May 2026
 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 21 May 2026 09:37:21 +1000
X-Gm-Features: AVHnY4Ie1EkZP4MVWC5BJhOzB-LRjbEQVuRJFLZbvO9ezWJOak9jMyGsYRj-ryY
Message-ID: <CAPM=9tx7aP08jEtHN5KOhekfky8Qn9U5LZqUybude3D3OVZsTg@mail.gmail.com>
Subject: Re: [PATCH 00/11] media: renesas: vsp1: Modernize the driver
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 12 May 2026 at 09:56, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
>
> Hello,
>
> This patch series modernizes the VSP1 driver by using scoped guards and
> moving loop index variable declarations to the loop statements.
>
> Patches 01/11 and 02/11 prepare for the introduction of scoped guards by
> splitting a large function to lower the indentation level. As the
> function is called by DRM clients (R-Car DU and RZ DU drivers), an
> inline compatibility wrapper is introduced. The clients are then updated
> in patches 03/11 and 04/11, and the compatibility wrapper removed in
> 11/11.
>
> Patches 05/11 to 08/11 then introduce guards and scoped guards for
> mutexes and spin locks. There isn't much to say about this, the changes
> are pretty boring, but generate a nice reduction of 148 lines. I advise
> reviewers to apply the changes and use 'git show -b', as a large part of
> the modified lines in 06/11 and 08/11 are just indentation changes due
> to scoped guards.
>
> Patch 09/11 continues with the introduction of a helper macro to
> simplifying iteration over format arrays, which occurs 6 times in the
> driver. Patch 10/11 ends the modernization effort with declaring index
> variables in for loop statements to avoid using index variables outside
> of the loop unintentionally.
>
> Patch 03/11 and 04/11 touch the DRM subsystem and depend on 02/11. They
> could be delayed by one kernel release (in which case 11/11 would need
> to be delayed by two releases), but I would prefer merging them through
> the media tree if possible if there's no objection from the DRM
> maintainers. I don't expect conflicting changes in the R-Car DU driver
> for v7.2. Dave, Sima, could you give your ack for this ?

Acked-by: Dave Airlie <airlied@redhat.com>

Dave.
