Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CB9CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B143D10F127;
	Thu,  2 Apr 2026 07:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uYOthpD2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XXEixpdL";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1273C10F129;
 Thu,  2 Apr 2026 07:01:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fmXpQ4PsGz9tyH;
 Thu,  2 Apr 2026 09:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1775113310; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD+qogYTEe5G3bMmgq5tsZPaYXL17CNBmjDXW042no0=;
 b=uYOthpD2xdg1352XJXlxgTgEykFloUJTdciEdzwGW8xF/FOk4mR6vVmkPSBO5b47OO6j6k
 MP183BOjq6gkz5XwwEFHL4DxpBabpAYrP8t+a3SREpu4XaFOZe3C6gNoGCcahCiDL0c+46
 gpWsb/n9mj3UFGUUrR68NBwTUc2EzmWDRcKj2uj9J7qnWmM9jCqaNCjSv58ob0vrA/8DvO
 +D4GPrJKCY90u3Q9bu8i1OVb0syQv+dyrhYUTge556WTyPo7ZQao+uzH12k85DocsFnXGv
 PkSetxz9wK5RuWWEmSE+EQZHtDE1BRHl4/9Z66x2nu/eKfLt+epod6HxYJZPqw==
Message-ID: <aea84d2eee808ba4c3eb462f1371b478f8e58ae6.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1775113308; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD+qogYTEe5G3bMmgq5tsZPaYXL17CNBmjDXW042no0=;
 b=XXEixpdL/mFjugr5cOH09AY7Z9dJXIpH2MEHeV2rUo9+nVBPxYeP0dJV6C4yWSQ8hsV46F
 nbLylsDLyBy5bFY/cawoppVWfiwoxqOI0p1xfPzXTlpqPeszcVLAgzYKTY6hrqM6D1Ybgl
 zlLA6mj7VeyPhZIX8QEPkkI3hWkU9UjYpClrrCFRXcfk4aLKaRUNa3rx6l0ytHfRMZccCU
 xOh8+tzdell3Wm3xRalHgL8hBJr7sd5IMa2toYcbHW++c5G7zmBzNudONQfVmhizwZMr0r
 j65adUaTVqWED+lHwVu/EBcDcNnWFUw1TSKDobF6+i74qtALWGDzsmOyKVmRZQ==
Subject: Re: [PATCH v7 00/29] Fair(er) DRM scheduler
From: Philipp Stanner <phasta@mailbox.org>
To: vitaly prosyak <vprosyak@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Leo Liu
 <Leo.Liu@amd.com>, Lucas Stach <l.stach@pengutronix.de>, Matthew Brost
 <matthew.brost@intel.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>
Date: Thu, 02 Apr 2026 09:01:34 +0200
In-Reply-To: <9ed0f453-23ad-49c0-9ad9-c14f1999dba2@amd.com>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
 <9ed0f453-23ad-49c0-9ad9-c14f1999dba2@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ss85gsic9xj1yr1q6jt11wkgrsfsquc8
X-MBO-RS-ID: cd8a32e3f41d1c714c1
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-04-01 at 16:01 -0400, vitaly prosyak wrote:
> Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>=20
> Tested the 29-patch scheduler series on our CI; no issues were found.
>=20
> Thanks,
> Vitaly


Thank you very much, Vitaly =E2=80=93 greatly appreciated!


Philipp
