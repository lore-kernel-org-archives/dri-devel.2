Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2582606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NlF4Awt2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298A4112679;
	Fri, 30 Oct 2026 07:57:54 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2122B112675
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:57:45 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso361647f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 00:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347063; x=1793951863;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
 b=NlF4Awt2gv0Ely7SCwTKjZPBQDI4wr9rJv6/qGsj9n0NVtCm6YkvUCzoRFXY4kilhE
 LgDKlFZKUU0BZT5xALI1U4/AIldSC4UAsKZ60ImX1CmTy5+VUg/EyWAFAkML9CE3U+SH
 qDehghVv0/5StHMjiSo4hpIpy7XuN5IoJIGz1ARZur+mP3zMLGhRC5nJyniz120RFpTz
 A3wo8kcVxaAJKxfVdBdGrCaT5+t6VWoeCUE45M984//A0COklZvqX94gkhc/a2oDbYsG
 cvNeoQ6AK8BHHTBbk6HxjbQP6nhRGwU/xrNS0Q8y5iwfKZGxADBiEoIQSBPaaH+oxULM
 LUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793347063; x=1793951863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ObLQIYquGzBiqCTd14UQGXrFZOGeRqctaF0y4LnV60Y=;
 b=BJPueViJ/1jU6PN1TfvLta69ctr7jEIEWaTKto/V4pX64HgsjzBXBhwDg3AC7Tba4B
 FiLMRECBqSaXGTrCGSWbf3UclRgJyKP50d8qYb3uUFtOOf/74kvxi17uOR+ZFc6H+yd4
 7kfInvY65RC/fPYRQXakTfN2/BVu63Sth/tRNLwsvE8lxKMlERtITb/4lJd3waAgwd41
 AldcBiT1tHgP7RARjwDXS3AtOL6Qjn6o1s4oLNyCwQqeTPZalAUxmDlVg5/tBzjT7npR
 OzLAOV1PCt8i2Xpk1p08MTIMgI2eOZBCjtdExDWRdkQWZY5dxd2MYfmUH1r+dNze93j8
 basA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSHF4+dPZvBNPnrs3hHrcRYPRzqDr/2IcmDVQA+FNAV46mMGXIhXRVAjY8MK/5RfoP0llEpI1gjdE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLiXAp+kZvIlP/cR3hyox/pMCkWIB7XK3WE2pD/TIzP0WbXKu8b
 D11AqyM4clD1Ij5o05U9i+7FSrRurq6NpPmkYViWHilt2UgJNOMR2MCRjahl1ToUpg==
X-Gm-Gg: AYBFou2sZg65zq8LWhXcSq5DiEx1HztMiiK+oANoOi/RZSpsGa2+fmBvjUvNSB+hb36
 FuKkXEQdqz1CkH6FMn9tCoTtAnf5xqyEe0/qOw79f94wvQJWqo1y5t6Wi3g3SuyhjjFr9d4FqLR
 6l936Z5/ahpQq+F0CQ5mT72Jg1aRJz35JKlGe49uDxyiSf0O9aPHP78nq+Wh8LXGJLtIze5uEO+
 BvjJ0vbzdaVK/sYtSr1+qAaBkpHY1fKTHDnkDYEV0DTuSYrERNpEzn6FKODS//wOYD0YOgpeiuh
 5FEBrUQ2+t/tDgjbEHWeGkkcyQt5n5Nyw9ogM+4rZMPP4LpbjIS1qt9aH6hhVytus3CSGn8s9BB
 mEDWTNtDsTPQ+vfky5JLnJGazDmn55ZSrwmfnr6UWJXPEy+HLYqd0uJCzu0vilHFzd4qzapCbr5
 k4+wvRPZKLys8aVQA98GNiJ1xbgldRhvAfZznCaB6yIEgm048eBPtH83mdWQxKbJ/IE5vE8J7EE
 Vtw827C3oRHTUG2Uffxq3sImwMqbB+U5XI0IgzZuwBllgXokuyRtqOuFYyj2m6TN7ppZ4oA+EQh
 fKzzSq0lpmXPPFtRLiK+MU8FlcgsYbmg1onIUj2DhotMhBxXlIvHZrkTtgybngE5lMIIa3xiOlk
 I
X-Received: by 2002:a05:6000:4a19:b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48e6e4f4405mr3497370f8f.30.1793347063048; 
 Fri, 30 Oct 2026 00:57:43 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm1675411f8f.42.2026.10.30.00.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:57:42 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
Date: Fri, 30 Oct 2026 07:57:35 +0000
Message-ID: <20261030075735.356811-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_PbewORwc3Wsqw3VQESz3RNAKJy+KdnWHx9J1rKg35-Hw@mail.gmail.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Alex Deucher wrote:
> I'm not sure about BACO.  In the BOCO case the OEM has a mux on the HPD
> pins that redirects them to the EC when the dGPU is powered off.  For
> BACO it's usually a PCIe add-in board so there is no way to redirect
> the HPD pins.

Agreed, and I can't test BACO anyway, so I'll keep it BOCO only in v2
Mario, sorry, I'll leave your BACO suggestion out unless someone has a
board that needs it

> Mike Lothian does your system have ATIF?  This is already code to
> handle this.  It sounds like it's just registering the wrong ACPI node.
> You should be able to use the existing handler.

It does, but only on the iGPU: ATIF is in SSDT7 under \_SB.PCI0.GP17.VGA_,
and the dGPU node (\_SB.PCI0.GPP0.SWUS.SWDS.VGA_) has none

What arrives here isn't an ATIF notification either.  _L05 in SSDT9 is
just Notify (\_SB.PCI0.GPP0.VGA, 0x81), and that path doesn't exist on
this board, so the interpreter aborts the method with AE_NOT_FOUND and no
Notify is delivered to anything.  I've put the tables and the errors in
a bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

What I haven't checked is whether the firmware would flag a dGPU display
event in the ATIF SBIOS requests if the Notify did arrive at the right
node.  If I alias the path so it resolves, I can turn on drm.debug and see
whether amdgpu_atif_handler() fires and what request flags come back, and
if ATIF_DGPU_DISPLAY_EVENT is set I'll use the existing handler rather
than add a new one.  I'll report back

Mike
