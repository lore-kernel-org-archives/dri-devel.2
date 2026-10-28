Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2B606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIsj3W/K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B8310E053;
	Wed, 28 Oct 2026 00:09:17 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4617110E053
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 00:09:10 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36a17a332ecso525266eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 17:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793146149; x=1793750949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
 b=YIsj3W/KaZBXuFx0CcUpWMVNmelk2ajCtOTITGfxbKcxlwegWUoSQulpZ/b9vxKcfg
 8PTQronEyF1aXX5X2Wvmh6NIQCRsL1X68+yRjQH5vR7loTraeZD2rOPGxrs4Vx7HMPVj
 rgUv8eX+/+T7dQ4g6k/5fmCrFtHzej3Lj0OG/AoTDBxJpnwAWuZdLQ4Xi2P77W8OlqiR
 0Lo8eHa/fmT3M6udzniTAb7r4Eks62nwf5s87a2qfwDDxXaMzIoSyXXpsDkCOGms1c65
 Ff2Cq+bpRKz5BG84Clfaa/s6XnF56dVQCqYAgDdlsio8wHAFr37VUFoXvEjrpk2UHfH+
 WBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793146149; x=1793750949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYaht9shbFWxq4kumOpndSaFwe2UdArezXMn/5BLyPQ=;
 b=ReIqNzEWKgPyelen33q5S0VNnqbYENfSzYMb3QFGuN3d+cwGmmX3tP2uxVlvDF6qii
 QVbNzSHOsr3UzE1fgVylqrs/Yc0AsD5UaTNo79jsg168nybUl/n85ArgmoKc4TyJc/FE
 s0S8JEj9gx7N8HlWqWYIa3jkqEgEkI49y5wdJtmjkb5YX7euIIPBCTWvjeE1Mp3rApEP
 IDl91EKxzTFKBvFz8amV2B0/yCkjIRBQNMR0az47n3tKzw6AqH/HxX/hYjLpfWtt/t31
 HgGn7dNVh+L+AqPCghFzXuN0rZ+XOcwEIIwCHtubSFc6koDg6f1V99+XYf3vuxzXPl1a
 Vl3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/j14Qm3zFxyULqH5keKz8HC/P1Z0PbhZh9JyjgbHCVYL868T5QaccBuYotsrql3W1FFNJN57Z/vU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIKu7yJuQiCYXWP+AfCCrexbWkSxchUaitLGPHZ4j3LgTPwDxus
 JIVrdurjuq3hqHUcnOZAlsDGX+WVNc9Ah9x9k810F4hKebiSZAh2SEk=
X-Gm-Gg: AYBFou1jeLoiWaWCs0rWGM9szEEUxRZNsukFBzILL1FDNiEMBNwAcIkFdjM6UIxEatn
 NpF9FI9QpspnVIu1QWmSlqZ96a5Xcequ09cBwvq1fRoPFZaHNLz+pbHiPgG7MtjhKptQsTyAq5P
 u5A2jRiAcwE5VW8wCeLVU6Ou2DO0sHVeMrGdwjZAJ7CZyS8Vcfb94PeORPy5eN3WxPCcUkGz752
 5wIGBeEBlZpxJblRWl/DjE+WjU7+F1rCiVWzqP1WyIDuT++HqV2F4kB8shuWCtqOUj/rrmwISkO
 SHD2lqdBEtP6bTjFLOLD25ppQecaQHzVVfGkiMVtPe6M6R/IsagDIDyREXsg7A4ffwDD02iLweD
 KI9EOrQqTEd7nE6G6qNbd7v09KUqs/MPZA/yo36snrldXp3HCXf6Rd0h18AQA4C8XFYR1Q//b7m
 JcEXHhZqlhgIhtDmsVq4YxkBAaTovkz+1OK6OE6gVEgIgJJpZ8bvR2hLPSrXNdtfc8GNU6K9d5y
 IMCrlvOKJWoXiQMwYL6x9wfqTkWrANqFlWnh8xJnDirPruXkL46NDViLvbXhNmKDWuc4GR4o3pX
 Z4RSzpVO/tDxTkbpqw==
X-Received: by 2002:a05:7300:c7c3:b0:369:9af5:7bc9 with SMTP id
 5a478bee46e88-36a2017929amr1084712eec.23.1793146149163; 
 Tue, 27 Oct 2026 17:09:09 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.118.107])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239198c9sm336354eec.15.2026.10.27.17.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 17:09:08 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: helgaas@kernel.org
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 bhelgaas@google.com, bp@alien8.de, christian.koenig@amd.com,
 dave.hansen@linux.intel.com, dev@deq.rocks,
 dri-devel@lists.freedesktop.org, hansg@kernel.org, harry.wentland@amd.com,
 hpa@zytor.com, ilpo.jarvinen@linux.intel.com, kenneth.feng@amd.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, mingo@redhat.com,
 platform-driver-x86@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on specific
 amd devices
Date: Tue, 27 Oct 2026 20:08:41 -0400
Message-ID: <20261028000841.6816-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027230042.GA516670@bhelgaas>
References: <20261027230042.GA516670@bhelgaas>
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Reading or writing to PCI devices in D3cold is a problem on every
> system and we should avoid it in generic ways.  I don't know what's
> special about these MacBooks.

I did not know about, i will try to remove the ignore_access code, and
will tell you the results, i added it as a failsafe

> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -688,7 +688,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
> >  	int type = pci_pcie_type(dev);
> >  	int status;
> >  
> > -	if (!pci_is_pcie(dev) ||
> > +	if (!pci_is_pcie(dev) || dev->no_pcie_port ||
> >  	    ((type != PCI_EXP_TYPE_ROOT_PORT) &&
> >  	     (type != PCI_EXP_TYPE_UPSTREAM) &&
> >  	     (type != PCI_EXP_TYPE_DOWNSTREAM) &&
> 
> Nor does this.  I don't know what the purpose of this is.

This is however nessacary, without this The CPU just catters, so something
used the PCIE address space or the config space of the bridges, unfortunately
dmesg dosent show anything or journalctl.

