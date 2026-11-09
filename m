Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5D606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A165lcaO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5873010E852;
	Mon,  9 Nov 2026 10:47:46 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02D110E852
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:47:40 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b56c428212so893828a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 02:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794221259; cv=none;
 d=google.com; s=arc-20260327;
 b=WHzmm9/DViS9ZJCzXsNN7a9eDhqD4jWumBFuTrdzQ2XGc7yohHbx1poC4XsCTDEcpv
 6jJxHT/jgG6aVGqNMEYcWtjR3mJGTM2asMRZzg6qIjbEEQgw3VsD4bKVPTkpvmD3ZC+K
 U6yl4tJxCXbTsPaNnsxIc0K3siwYC2D3nTLTxqmXyUUDfo6FzNohKbWcexuylXQ+wKHE
 ONBOxBCkrNV38PLD0xB8MtnYWgALGp1BYsLRQjK9PpFcsbM/Y00WrSWDw+FEL5fdmWk4
 uJLLdZNr2pgwfwd+fG9P0H6odyZzhJflyilVT4VMMDbzZrB1Mts46ZlgmqlCeE0Fo7Yc
 VU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gr89SGnVPkS7ivwYKQs6+QlO+uklb8EEyqBOOsKhhQk=;
 fh=7iGYPP+n9mgYNPw22IwrxBs0Hi46T94CwoHYo2BAzQU=;
 b=UsMNBhbNSHTrUp54nZrOzECTlv5ZAfT9D4iIojzscqm9qrWL9tmcVfcKR7ZgvjBHos
 qdHJY2WoN4HTQpAjG/wPlTKnZcPl2jLKQEo7lXhPPaaXQKBkRa3M58ULuxlI+qJx9lUr
 NTSxpIKUp/fSdIVj0dwdHzdm3LDOummzzATVp5OZpaAedVFYSQhsyhC4nEYt76FeaZCG
 mxQxWPVjcwurlg98RnT1ueqhY1d/PkDMH7gg2xN5UTdbetMEVieuZffD1w/C6pukx5wa
 eLTBPU7mazQzsGj5QbtQfeSz9wn08hE0n51QiH9MISgVAbH8L+ofoAL1dw94Ost8Rn3y
 0f2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794221259; x=1794826059; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gr89SGnVPkS7ivwYKQs6+QlO+uklb8EEyqBOOsKhhQk=;
 b=A165lcaOgTtbbSEfIxLB0baTFc2lJ4/JiXWstuYAqXmPAhwgxjMBz5ilmfNgpm15fF
 el95g8IASxpYaood5Yr+E4MOY+SjX05b5V/BT03vJlbrCEEk8nKsFN6ad3RbHBKpSnOS
 92DMNN0SlaVwH6eldRMeLy69bhwunS1YyIhw0jUK8k+jhXNXzbPhqlSPEGkK1iL/446+
 gzEMMrv4p6z2mSK5w2oS1OBgNrp+/FBTN8WIUwUJOyyJm8m51hj8amoEjjQsKojzddr7
 6i5XbQxW/y3+ToGzJt1uyqnUPfohaTwma5a87oRk82BIju4S5ar3GgciLDWcZ6Fu5mXD
 bKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794221259; x=1794826059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gr89SGnVPkS7ivwYKQs6+QlO+uklb8EEyqBOOsKhhQk=;
 b=2HUVMG+/RQr2WhS6U5c+WPX1bxn/yI9h0Dyqzc/g4LjHJQTb7IaCVrs/8PKDdGBmfO
 ivTptPQhYSgsvkiMDigi/s1SDoNEVzCSMLezOSyqhAzoBPfXZpreUHVC3N0fyug4sg56
 4VWIm2esPEuUDbc3UBdJyhgocwYxVqYiPunVBgRh5qBWwVJ1K+AltKVohwayVVzlEfKr
 FwkA9oblIg8ewov81CdPDkoGi+9i2x3THgJ7nZ0zM1zfVMqry3ZYz021gOfSxJMSSMx8
 95a1ExguP18LPIhwkv4ICsarwLuKENlFBQw7yQfVwefqLdr9PapO72sSv7Qo/rhk3yxb
 W2/g==
X-Forwarded-Encrypted: i=1;
 AL+hErGhw22qSllXuRoBbgOcDyI9x1eAzhArwyPgYQ2ooh+zIBAaDVQ7SdvYVU8lFek989wC1lQjZNlRus0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+i8CJKENEAoXl36KX+xV/p4lfV7GpQB5im6MJGn7V6EMpcgfHb
 iNL0aQ4kd7mx/5OMy0GOgmzcIjT+MrG4OtAJbs1rRj0djNmnVXTgxoUuWKJrCu85alv9g3g3Lkk
 ASgx3TXaoOJAXZ5Xw+TsGwK6qAgW0ufg=
X-Gm-Gg: AYBFou29hxocmBysJSi1B9GZeVuktL4xZHkQVogp/v5nvvf68LofoEBiqF6wP2rUKjm
 rickkrqHbz3wpN05ploQ8Ehk9ireTIcXjphzV5uIrIUqSdMQxqdYeyKn8NYUf3CbWp5AMS9AuU2
 BRIXGW9GR+3HeCON9iaqUrwl7Qj4mR8UExJwLlZNbUKAb7taTEm+e3q7cE0L34J1XligTs1NoBC
 24Zxcg2jXuI87fWpevwhF9vd0TpxXEHAD66XUrHciyT1IoD4rRm9VG0+VugNbPi9w68I5UM2Ou/
 EgjUcX4kUc7G+hnqy962BliuPZ7rAv5NCZE0nhJvUioMp5PWIj+CTaAkZj2y/Gllb686/6d9/8t
 QtMqt0jpYCr3M0RoJVo8ipUfB2qu7eEEs5mUealjEr+EzcbZUvit5301ZfIIybixYCReQ38Y=
X-Received: by 2002:a05:6402:4343:b0:6b5:8723:279b with SMTP id
 4fb4d7f45d1cf-6b722498c16mr2574005a12.42.1794221259044; Mon, 09 Nov 2026
 02:47:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
In-Reply-To: <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 9 Nov 2026 07:47:25 -0300
X-Gm-Features: AclHuK-ldY8ob4J6VOwIqr8abP8yg63kZd8DIcUH2cZgu5uQzjvmJoL9cWR6RPA
Message-ID: <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Just a quick follow-up about Mesa, I'm still working on the OpenGL 2.1
driver along with the kernel changes, hopefully I'll have something
usable in the next few days.
Also someone tested my 2D work on a different SGX535 device
(OpenFrame, Z520), and it seems to work pretty well. Funny enough the
CPU is still faster at some things like fills and console scrolling
lol, but for copying framebuffer data the GPU was about 17.7x faster
than the CPU, a hybrid system would really help.
He put the tests and code here:
https://github.com/birdslikewires/openframe-kernel/tree/main/experiments/gma500-2d-engine
The Mesa part isn't ready yet, but once it is I'll link it with the
kernel patches for review.
Also hopefully Gmail has updated my display name by now, lol, sorry
for the previous display name.
