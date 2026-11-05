Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB50606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pzeq6BoE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D93C10E914;
	Thu,  5 Nov 2026 02:39:33 +0000 (UTC)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2971010E914
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:39:27 +0000 (UTC)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so613379a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793846367; x=1794451167;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=Oo6w/Y/6CCvZyC7oczu1NT9hKMhVk8zGNpqoL5sVtpBCl+i0ugUpg6j0AJl9Z9Xhpq
 rmkjppE0rKyCxFo5VceLaKZ9IrxgGd0BpOvyOiqgeUdIekcoA4939OU9u13bsb/nym8f
 Iz5cr/rsVG0r805PMgFo4gXy8efbgSkvsGa6HfOg+Neag2SWOnpLuBfIZrXhdlv7U0qT
 Xl8KoeI6T7T5qqsxlmnbNe7yERl8FkDbv3TOb1gLSHyZEqfbGByFwNJLPGvzJ/ezAl5w
 8qeMSlQQDWkI1eWi3khiZ0davSLjsV1sLJhOHVRwa4eolldb2ycdzYMw3wiE3ksEtyNu
 f8yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxchWK70Hw+JC/GzLURFwR66o7/8c+wdWUlzNUVLVredUXPBwrOW+namZlL/c51DJaO9PLZwAZhSBc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TAnVcR/NaqBTBtG9rif676SkSlDmeaWffhLfdhNgkIewKoEqJ
 9wATw7B6mDe0WI9KHuhEKTAe39iBmLUse7Vv2663QCClRyEbIz9EUomQndRidZAC4swwJHxLE/Y
 TtDYaEy1AIqpg5Cw6VAlyRox5dYD7Dr9glaIy2MmWB4U1VihGh79b64PgcEEgOujkRGAhAOxecU
 eqdtUXdOV/0tqrS1OIqpsUEJz9y9PlExZoq/JC4WBnqkDw66wa0dHByiM/BpMmRSJaDUUynH8BL
 /BHPQuMNm9l7n7qQs1G26xhZ3Cy
X-Gm-Gg: AYBFou0s+wn3yfnzEb92wKO8CqdGBgmZ/iW5HqSbXAFpkD0Q9MlKKD6aQqEwmPBviQm
 lavlYR7rJEYKgE4rA04bq7UOTxIP3MfkyR+2e0dJnmOaiKMcVw+rAfi4rdisjHrVWACXH/lht7G
 Rcm5m5wh/F3+dryswTibSHvSXnFToihiSLHnz2BfV1qaAhwV3kmOOndm0rLuZnt3hRMYp27zpvj
 zCpVP8vOhW4fNILnZKjKlu9K7oE6Z63aszwWWaZIaUTRGVxX+SN0+Hb5g4jA+WPy3WJxnHlvsaM
 HeQOx2xDKm0gE2WAhqxFUQkVCESIGjDcUdFvoj5H1DLFi3Qh7WTX1kRMqVR355b3OyGYke2o9/p
 YNAccKOs+Vr+SJPGFkHObvYAlQFPeJHlC/Wb4yxVqt8XmTDSV9fJk6TH5+9a/9iqqUJZLs9gMFj
 jKwqJN+Vt+dc/RjM31QJeuCk+Tn5syDjX71XzRCz6J
X-Received: by 2002:a17:90b:2745:b0:3ad:544f:81e9 with SMTP id
 98e67ed59e1d1-3ae8977685cmr13877753a91.15.1793846366594; 
 Wed, 04 Nov 2026 18:39:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b0a7d138d4sm723855a91.2.2026.11.04.18.39.26
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so2854929eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793846365; x=1794451165;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=Pzeq6BoE1jmC8NdSddYlJfdn/ZNxvjhwLIcW/V0MMLr5DIpiUNZSgRQPd2qq/G7J8p
 tpSoJytrDjURRhAjVXAQvQtZrCpX6zT/Mid9z19+Rub53c/dYhfV3HCYCALCf4MIFP1S
 lhGZzPJ6RhIriReqQ2JivMhp2gXnVq+LS4+NM=
X-Forwarded-Encrypted: i=1;
 AKwUvBzE0zzmLBlZxQs2UjxcLdeXxrNItxLbUCvf3KGzdybvyo+A6zlfJTAahZUxEQiRjTDmWKyFO+uCZS0=@lists.freedesktop.org
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id
 5a478bee46e88-36a6106506dmr20646928eec.16.1793846364858; 
 Wed, 04 Nov 2026 18:39:24 -0800 (PST)
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id
 5a478bee46e88-36a6106506dmr20646877eec.16.1793846363921; 
 Wed, 04 Nov 2026 18:39:23 -0800 (PST)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36dad72dc52sm4329396eec.0.2026.11.04.18.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 18:39:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:40:44 -0800
Message-Id: <DMMXHRWQ5FYQ.A0UTZPNLJ1MN@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <yunfeng.li.nb@gmail.com>, <tomas@slax.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 3/6] drm/vmwgfx: include legacy hotspots in GB-only
 cursor images
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
X-Mailer: aerc 0.17.0
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
 <20261027211729.646988-4-zack.rusin@broadcom.com>
In-Reply-To: <20261027211729.646988-4-zack.rusin@broadcom.com>
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

