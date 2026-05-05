Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73CFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDCD10E19C;
	Tue,  5 May 2026 12:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hm0rOtT1";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D630F10E19C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:25:35 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so4495872d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777983935; cv=none;
 d=google.com; s=arc-20240605;
 b=Rufq2QfsVMlo0Oi72sF7mvbuW+aShabLyas09WUOKaILL+fOzE5GwZ/VuSQLzcXAv2
 ooLFNotiZuHWWv7tvFK+RLq6WSoBh7ZlRo9A7x14/aOswy1Cxn6lT5QzPR3GFrC0O8Hq
 WU7pooV+6n+bzYNilqxPfP19mgTRrh0KKAHP7K9M0HJDnLwVFXGtZZ9rCo8QOT8sbhzQ
 FpNr/xBdvJ/X6UBQxiiSnB+SW38qkO9TQudu7nJ3JEj++8P0Jwz3/g1bDOJgy4isBAN1
 AK1LbH38Ujh+h1p71rOsxQdmIaCmo18URnHJC7km2lu6VjGUfXg39LR+ucWwPlYDLHo3
 78zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=HZWYzWladWJeV9q+/l+O6PxJw3m9uSCSBP6PCqtZITI=;
 fh=nfn5qSWlmfX+OcbDFkxpO5CtQgthukG998j5MHNEtHk=;
 b=MlY9iqt0L4saj/1b5KNYeFLRQ5rlZaA5IZfgyqtQiSXeiHi2Rzt6QFlSjRCZAS4HO5
 0v6xp7BMXeCF6Nkw2rvBsjbCTCQK6pXmP+dVwUuepvIX1yqgMna+xOfC9ei19b6jOyD8
 FUu00AzZPjUlNw9bbc4NTGM/4FMa/dwqANwNtqVIpTFo75Y5j75T0UjZ/Lnsi1x/LmF5
 RhrA/fCo2avkCvexCvUeLcK+H6/fPA1wkeHSInfYjdBh0xkCNRss0x3A12tPMKGB3MSp
 GesTod+c2LhiEeAPWGVZ3WYPS0qAz8oYoi6KviPPhu9cdyKrRcLx4RgiVVC6mkA0jz5w
 bF4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777983935; x=1778588735; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HZWYzWladWJeV9q+/l+O6PxJw3m9uSCSBP6PCqtZITI=;
 b=Hm0rOtT1QFJ1320N9u+qQkJ63rmiD4SGSc84ARgY8yIRMArpchgTK0T+B902nV3mpD
 4FlWICyQaysDLyWQckUH+lGpg47R7Q0/07fYowWhj62lghEPRqKPdLd3jwQcjLiRatl1
 su/VzZT+cLNABDMMEWDB4zvbeYLFT94iJNSh+cT5eVpCqkIWFex+9lU8wC6DSYPKNVPu
 AbafF4W42BtcXv6QyG6dLpbSNJnDcN2JK35kgfKfWLqf6NWcB9uj934RlWm2sbMOfh6e
 MZkON9MOGdhdkiC6s+42NtwgmUxhGAJSrgfT2/hip83eU7SG/jpzpL3TOKnzkHZTpuw9
 JfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777983935; x=1778588735;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZWYzWladWJeV9q+/l+O6PxJw3m9uSCSBP6PCqtZITI=;
 b=M6TDHRwzdQkcroK2GHEYOUqHcnBVZzfTDeYMC3+Gmcqu+RTnnW83geEgedbS+xC43t
 UHUQ51AbUAz6E00jo4NqNaAv0v4EZD+nHlzi09aH2Jf7b8a3N6Gu+6u0gxtknPCWkYDY
 QTna8A8vCkqWqLmCFKAJcXdbDjCLJJkkIEuX93wd2KpBV6gC55BUA/DCac7YJL8tBBEx
 0qqXVscb6TtbqNrgrciGaUcOmsaj0uetdPKDPKyG2uDY7meI/16OsYtuwp3jzzI4EgTN
 DXVpWUyKho3O/hpWf4fFZewtnNQcMtWI/2gjLDnKZLdiLt2wDc2vFcvK4wpFlp2glRVr
 U+pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81w+iRndeBFrgA4or3ca+YBzYTjGRBEksTSSSLJvI6DaFGnxO4tSGcamRipLDAxvMKIRFgVnE8yy8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtvJaC1KsN3wrxvHsB/HNOKkImN2YWXldwbj24xyg5qhC5+1lP
 uu+Y3wCYBlYbfW8hU9r+u7+W0nTKZGNl0ZtiGvH9yORookb4o2f9LsBIcVZ1MnAyypfT6/MTbYi
 dBNxlRsp/lDme9BiHxD8F9nOWSXraikM=
X-Gm-Gg: AeBDiev06UuzGQAvgcqH0ayEG3+fbYxtO6TaAXu0KFtOhbEaOiYpS5L50bdVUGiBScn
 8KmMtvWFNmMhL+9YAPajt/2Ts1VAHa5Zm0PGXD3T0svhsi/SVEVxibpPY85ifQGwBZd2gsyqSBa
 /LfglWeD4+2TAiystBs2l0GrToIt9RWnJMylfP49EoCT2lOAsYGYoVYqYerMCxUXsx3bPZcoaiX
 bQHYDE9VAWBV3fXnOdCywMl7+ArqWt1KYK49tHlXAaHG0IWt6dqUwnpvB3QWs4liUcsk9I/cr4E
 9/oz33NDZaxZh8HywWrK7FBLF/gHedj3FHASaL5sbzYehILBk2GB5ffYhhA=
X-Received: by 2002:a05:690e:bcc:b0:651:c642:92aa with SMTP id
 956f58d0204a3-65c3d96c23cmr13772518d50.4.1777983934692; Tue, 05 May 2026
 05:25:34 -0700 (PDT)
MIME-Version: 1.0
From: Julian Orth <ju.orth@gmail.com>
Date: Tue, 5 May 2026 14:25:23 +0200
X-Gm-Features: AVHnY4LL44QJqBkbe9sCcXJw21A8-75K1LYnugX0XOneV6VVtcfwiV6fhBeQKiE
Message-ID: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
Subject: Regression due to /sys/kernel/dmabuf/buffers removal
To: "T.J. Mercier" <tjmercier@google.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 corbet@lwn.net, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>
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

In ab4c3dcf9a71582503b4fb25aeab884c696cab25 ("dma-buf: Remove DMA-BUF
sysfs stats") the /sys/kernel/dmabuf/buffer directory was removed.

I've been using this interface, specifically the exporter_name file,
to detect dmabufs created via udmabuf. Such dmabufs show "udmabuf" in
exporter_name. I've been doing this for two reasons: 1) to detect that
mmap on such buffers will be fast and 2) to detect that GPU access to
such buffers will be slow.

With the removal of that file, that detection mechanism no longer works.

I'm not particularly fond of that mechanism but it was the only one
providing that functionality that I could find at the time. If there
is another one, ideally an ioctl on the dmabuf, please let me know.

Shipping an entire BPF compiler in my application, which the original
patch suggests as the replacement, is not an option when the removed
alternative was simply reading a file.

Thanks, Julian
