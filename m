Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5759FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C9510EA2F;
	Tue,  5 May 2026 10:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="eOdqEAAM";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E2810EA2F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777975833; x=1778580633; i=deller@gmx.de;
 bh=+FYWN0gMWsbPStojfhvR8xHwDdJSZb8ba9PQkYxnm9M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eOdqEAAMKD00nzCh+ZTurIh4HdMDj6ie2Fn9fNPkG4ygVrDCSRgG68nAhAVk0lon
 UDSuP19akTN4naOXxDNP9SNrVxsEvgwKeslt0mm3PBp/M+lme7/gaa3M6PRG6yf7y
 1asyHo/6+vLiXmKZ4F7Y9kYQPG89XmeXztHXlgoLGuSXlF3YydTfMoV4rcU4hzS7C
 faIqIB5eyTLNUZ9GRvR+4LbKsnTKVidPOYfh+VRZHOwgBkmpikftGVMNVni8bXqsF
 77vlw+bHz38rnLXqPgArYMpHhVDEX2a1/kZWVzvHT6Zm3YJ1VJ6G5t20tkGlmTrOT
 CdwouJIV8cN+w5al0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1vMu0Z3q8p-0128uC; Tue, 05
 May 2026 12:10:33 +0200
Message-ID: <2bf485cd-0c6d-4f0e-99d6-7b592b949a1f@gmx.de>
Date: Tue, 5 May 2026 12:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe
 failure
To: dbgh9129@gmail.com, Jason@zx2c4.com, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu
References: <20260420010118.17960-1-dbgh9129@gmail.com>
 <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3UvJQWzG5aAMJKD997JwrZeRSztM0awslufpy6frJCYSIcCCyGV
 p5bixwgT3rBZnfmTB3dYfVZpLyu9UG9TQolf/w410fxcUOlNXlCrqNgubX1aqFHxUV37w+b
 LBtnpn3NhjB6z+Oyu+nDMq5zSW+82lbWwwfEn74/traxdfF9524CKC5ZGCpNCY4P2OPEI5S
 SNVbeC83kCFSwpO0LXgeA==
UI-OutboundReport: notjunk:1;M01:P0:tlyrnwC6rc4=;W+trPsv8dKk3PlC0P6pO2z1b2b8
 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
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

On 5/5/26 03:39, dbgh9129@gmail.com wrote:
> I am sending a gentle ping on this patch. Please let me know if you
> have any feedback or if any changes are required.

Both of your patches (offb and savagefb) were merged upstream 13 days ago:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log/?h=fbdev-7.1-2

Usually I send "patch applied" messages, but in this case I probably forgot.

Helge
