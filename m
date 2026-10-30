Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=HaFRgTgz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB0210E671;
	Fri, 30 Oct 2026 00:50:28 +0000 (UTC)
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com
 [74.125.82.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D516B10E671
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 00:50:21 +0000 (UTC)
Received: by mail-dy1-f228.google.com with SMTP id
 5a478bee46e88-36a17a332ecso404167eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793321421; x=1793926221;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=QRdQ4flYwoMMAnrpAptM5wwBgNfIoHjTpaWEZaxO9RkuSYI4O8Yt7CMXUHYs7WoSaM
 XhzEPsOcxHFmUSgteTOv3RZLQ8Ps9TMo+ALuTZcO0a979diSnmar0ZPp1Qg884mgfjW9
 f0qmGe/JCcCtPvrRXBXn9CPT5hZCcS9aBCEeaWcIcpVaRdcIjmfHSXE/KgVlu2RaRn9q
 ePke5wy0RwEGsEnUxZPxkvDFnFxm8zPeqQ9W9kCHDU+DLaeEuqthggdD++cRRGT/8TzL
 037wz8B8LiWltjE5KVFantrwQ/AVsvnYwPi+znOydnzDY+SsKxDDtPWB6REhUf6CWZw2
 e4bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGNuxaBHCTLtkSOXbqc2kENieiPHGCLzQsvhgQAXCFAcl/kqTuLBcBrqju6F7LM0KYiulKEcT0/ac=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLDxLj3ZRSLDXbFWUdMjAYR6NTriWveM48jig8qxGHaEHbNgVMs
 5nFKRYyLKIqkB8iEtJhx8r8vgfvexAPgyOgxbJGa9lccDzveIs8NIVJ79dGbSNfsIX/xr2gTtWl
 N05lKhF5L5H0RgomSTPJUPNLAwnWg7rlw6Z7og3c2G4zuTMhCEGeQDZZXlpBLGv4HhCnbF2q8q3
 XjRJ+y0KXtuA7sLs+gnrZyGwkRv5dbwBM65YQ2XPnqr8gezsbNnK2H/+pk0j2q/Vm/2LB7ZcVzO
 ggvWKJHtUoiRq22v5Fiv6ES9fQU
X-Gm-Gg: AYBFou058scHwocbh0C5m68rwL5lzrw+iG8Sm2vUXwvajWykwtZxfaf1NEeN83AS17s
 3jUew+j9MmWrgEW2K52+ObPGf9aN2nhl3EzMwtHmQwwKrRKd/KEOGYQTy6aUXAODYDfBu33ts+H
 Ww5/1vuZ1b/Xw02SUp0VK0y+M3KVhRmC+WQuIqVrnvvC0Eba5d+xaTq/HP8rhE6Ue9eCbvV5SJT
 Td2hkJ03GxGzYjxaMS0xek2Wfn+9QlwMr+ztNlBs8GXZLhsws5hNi0dSugawUMG/zmFKwZSAAbk
 4S32oNT/YOzs+7qDVcNFxB3wp5IV5iQBrFqOspBlkFsdPjf80kmGSkXxyTx5bwNBjI6mBlJPWP7
 cC6zFLc/hZegY5hIPugUo/INEkdi1N4s8A34w92XOuCbzQ5CaD5/phirSP5q9IO2QuucAmju8hS
 7icPh09ircLhLhyoT4FLsXi66S7n5c1nO3NMBWopXF
X-Received: by 2002:a05:7300:aca8:b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-36a4244e81amr1884469eec.32.1793321420433; 
 Thu, 29 Oct 2026 17:50:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-36a428eb1d7sm9914eec.25.2026.10.29.17.50.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:50:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so5006716d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793321419; x=1793926219;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=HaFRgTgza47CduGdaWD3rxyPPzG2xlTsWN8TJj6fwBTAVyXrHMAt2ndRI+TNORZ45O
 4XDvh7AnVb2z9FeMxIK2rOctILPrG7mT2OH5GVq/2/vmJLZj4jS1z8bBNQeTXCh6rera
 Gfin76lgd34+yJM1FqBYR99vSrO9a9Qhiq8Wc=
X-Forwarded-Encrypted: i=1;
 AKwUvBwTup9hvPazubOEXdiWx20Yn2I5luj0Otj8qhi7NRqQFMo9xjdk2Y2eBfNKZwbcnZpWVd1TR6UlgcY=@lists.freedesktop.org
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-944217bd696mr156469485a.47.1793321419186; 
 Thu, 29 Oct 2026 17:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-944217bd696mr156467485a.47.1793321418692; 
 Thu, 29 Oct 2026 17:50:18 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442581b293sm6674585a.8.2026.10.29.17.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:50:18 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 17:51:39 -0700
Message-Id: <DMHREZLFJ65S.3CBW2WL5U0DRS@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/vmwgfx: avoid underflow when stripping short
 GuestInfo replies
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215738.3010276-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215738.3010276-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

