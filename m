Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA1FFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EABD10E36D;
	Tue, 28 Apr 2026 19:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K9vQnNuu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13EE10E36D;
 Tue, 28 Apr 2026 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777406316; x=1808942316;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=81HopLCxPBQ+dklocC+kF69f1mjZOxDOL+zuqJXxF0I=;
 b=K9vQnNuubxLaVVW1uSHGyUn840HeWZikiXAXHV9yIsxTaVfRd9oFXft2
 g+BJUYy5y68X6Zy72HTVqzvX1Lcc4tfHOU8kLKVgf6IA8mtw/gBEblfYb
 3UNcSLN+xHqzc/pi75qRmVF3FL3JhEOGkXPl0CPdQ2z2VS44If4cIYqdf
 JYKa8bOTsVgVszG63cc4/htGTyt3XANltE4u5M16Ddan+bvwnWhbk5WvV
 N4aWSKHrcfa95KVceS1j6ykjNrkN85AWQtVk85Durf5vGj2My/YQDBc8e
 sIcpUSIAWvXVOZV53j2y+IUTJpPHzmZfEq6voxagbh+aCSm7oDtf/CdUc w==;
X-CSE-ConnectionGUID: EXk/S9qwRD2CKAuopqKyCA==
X-CSE-MsgGUID: jIXVOIgkSL2V+WI9im3Xpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78518527"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="78518527"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 12:58:36 -0700
X-CSE-ConnectionGUID: 1WZKgh8lTxez/Q7YHwY1mQ==
X-CSE-MsgGUID: H4j7WE3HTu2a0Mr0wPTnxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="231405369"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 12:58:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 12:58:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 12:58:34 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 12:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWaj8xGEdRBvBiBNcRxIVh8i4hThYlWX/eXk+DYfJDP+OI2s8hhalo2Jqdh5UwrZauwN64Bhd+NHS5vH4UQXPJvov50Q65GBicGUnOhQ+K8ECCHnQup+lmNZLEQo63tGpCNND/F4qlreRUx6Je/uoDqBKK4nu2zaq0ba3UMGcX9W8qXWwttV+zS2612r/bzeLtbB2NldaDm1bTCkXgl3pyJIIHgPq5iqpNO+o5IMD5zfycxSgIn3rClBzGCDv+eCSPZo7GdTlq9x3Y3JQNgqiGDAXN6s4I7E+eY4DmdIRhYGyMu8xw/wCQNqUnF28/1zsNn/1a1w1y9nq0oM613G0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHIM/iqUSSEQh/jLr08zyLbLL7qjgkvtCpHbxVGXa4A=;
 b=VwP8N0036T0o76/FLd+MDpAxq4TQK9AN3xVusrmxhH8cP3JyvLWWSD1D0KLgm+EEuwWXlCMAAcQhL7OpeFika/qkjdMaA1s5Q8ldPibQ0NBflCnvYhutkdC7LP96sm4mYb7thWPbwe9ocNfqa5naVCjMoFdND2156bQ8HPI1NbmjJwJEqS70SNO1C2NHxJZkFhhJgz79GkBIkXxbsBkI142qgaL+fiA2iDuE3Q24scTJEcEAuth/NTlJKbrhV/VKwAlfk3Le93ZoQpawHWj7bI+6mlRvRkfVi6OC3ZREM0JHJvF1SpnTmu7JGE0W1Z2ZU+n17X8rSEd15Iic5XTPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 19:58:28 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 19:58:28 +0000
Date: Tue, 28 Apr 2026 15:58:24 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, "=?iso-8859-1?Q?Jos=E9?=
 Roberto de Souza" <jose.souza@intel.com>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe: Don't use UTS_RELEASE directly
Message-ID: <afERYJuuvZmexQ4-@intel.com>
References: <20260428102527.189593-2-u.kleine-koenig@baylibre.com>
 <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be82fd356047513f23a3193d8007a2e5e8d97e35@intel.com>
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6d6068-8c87-4947-bfc1-08dea56083db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: opNY/2u003ZsH/Ai+s+BwJ+O27sIBy1xDnhmJ0+eQ/aYW29zcVEjifmycgBDi+95tf0TtSrsedZnbuVb6vciOLGaLbcaA9h0BMsFJ3NK0vMk+QzypuY1DTDqHioC7ucVCBX4n53qTzDoS+1HktMgx2OryxwYnOW3FPdFhN2MewmvwOTlmKQ/bku0InoECphBq4bheDJ/qe2cbmbcBkoaGTOBTf8EUPjwLDsRNn6SRNkszX5AbsHH2pjUS6HJdfZWNWauefZllPD4G3E+pXA/ipofNrNe/pugm6sYDdQMxHhKjCysaOAS6pfuQA49FdC3xgc0pBfVDDEwScLvv8oI8pX1TvHfsIoRDDAMkDH4mW1xQC6lcdfuyzmx4c4Z3BbBUoWofzVUOL8Q8CLZJdh7AYJVb9VN/v0H7JK2TmXHlh4QBmHZ2I9MRGdEU2isHVl3A6sTTWmE0DP71ojodLnhLEi42IM+yeEJyDXPux5sqwdvz1pZEzDo+PUsM1y1utlT3qvXT/gv4aCRzDrH82v6iKR+07vNbYA3479lx1w3K49DbILGZ+w2z/7FHgQAL/ge7ne9WI7CQjo4bLgUftlUO0xLUhP+TnOHqiG3R2Ek1dcv92W8Fu9ZIUJxKB2qSFqHFhoibKqkqQmcLxh7RnLekpHh6Nm26BhmieiVDDW51POaj2dLS1p6hBAIwThyqu0n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?L56sgXdQEpgoM25KAHB9DmiDbOf4CzYmEaSlYXdhHZE3ziFuMReaN4dC+Y?=
 =?iso-8859-1?Q?B464KuP8BYrJBv6/ztqmQNLxSGaPhDU64vq3J9zzHk33S//AcpmSbI6vjk?=
 =?iso-8859-1?Q?6O4CyTtnkg7K7RYfm2Qu7V7rU6Wg6Wy8b/t5CMiE15yPa+dBwe1ZOQpXO1?=
 =?iso-8859-1?Q?UHyeNhKr9rkVxS8+CZ7tfuOg0gZ6JrgyB0osGbtx7MzgvNcy+3bT0J+/y5?=
 =?iso-8859-1?Q?4tNtay1hbvUJ2GtZG1h6FNaEKiCkqtpXp08S2JNX8qpKb0nPMsVk+577Bl?=
 =?iso-8859-1?Q?DIzAkQsxJILw2HAbFwuq9HAe4hIaSBlPzdot5iwEXpzqTobwXA7dFx1W/0?=
 =?iso-8859-1?Q?ltyUAee+N5sOk7IUUVn7sMCRYaSNgjzlOrYBFI8dhthGt0TdkiVOGmcKXU?=
 =?iso-8859-1?Q?5L3Oya4LfP9+a/5GNyIdhvNglYL99ln2w5PJNupK4NauAKgOvJlnZolOJh?=
 =?iso-8859-1?Q?zlLZPOVOQixuveStKV5CdwkGNKJSyGS6zBfPqwfvjOUAV3ezePLgPfL29/?=
 =?iso-8859-1?Q?LmoE9nuFtVm9oufnnEGVK0LX+TUXRWXHqGY3ILaiWP8R/GH48JCLyLPcSW?=
 =?iso-8859-1?Q?sg08/KKA7Vw5HCBbYvl5SNwlT0H2jspuIh4kDexns9CcatmdeY7ce6P19D?=
 =?iso-8859-1?Q?eVWI/Dhy2OZ6gJTw+edzPqlPvdC+GfjT2ZjqXzOzeTdKYINU4Xw4JqAVM9?=
 =?iso-8859-1?Q?MUeF80u18nihMgzp37y0lboND5So/pJ3FwLq5iBK/vjN0X22vpW6SpcTdX?=
 =?iso-8859-1?Q?yK6c/waSzPGbHo1UThSgxz6hPsXK7m7Uysu1rEqS0QxlIovx7nEQVZsY+n?=
 =?iso-8859-1?Q?vJwpm7b411g5Hy0Wc5DnD/tqxgl4ureqYYbqcShIKVMCGXYE2CgqbE6L5P?=
 =?iso-8859-1?Q?CAzvNJGqokGjykquSpyzpUa5PaZYH0+x8TDbtiA/sQAj4NC3HITWsrZMuw?=
 =?iso-8859-1?Q?/2FqOwJeUZcF0t/0X3S5/RiPOs7YzPc7uCCq+hbWiR9ZbBIoJ8OfJC9GfC?=
 =?iso-8859-1?Q?/IwK2fAidcpIjkDfX2NQhF5Y1S6FBF7wVZjNfLEa5hZYET4gVCWdMKPyRB?=
 =?iso-8859-1?Q?PZFEP+ANhaqH0HcpccrPfC6UCDAYd9ZcrQn0N9iL50eCw+sXbSHFJ9GKN4?=
 =?iso-8859-1?Q?nrNEY89nTxlMJ2jJBJvQDwOAVCVcxFOxMWMLHdIk77Ob6uJ8rpMEeovrei?=
 =?iso-8859-1?Q?kPNWaPsicooQxfh4LbM/FtAxQn2/zndrXdInL1EnAwxcGt21MD79rwpYx8?=
 =?iso-8859-1?Q?vXlM1Ta6uj6WiNXp3uNhcG6msM9FcP9+1ci07RKtf0RcLNsewoMAC5oeQj?=
 =?iso-8859-1?Q?Bvpa/cUPAmJuDKoldj+1+cdpxFJJ3099Vg9i91b9r8OFRn2gl0Sng4We9c?=
 =?iso-8859-1?Q?J9E+M6Su+0PwQ1aeseVQQ8ICWvafv75QP2bRl8EUo6t8n3DFvaqmYHDEsD?=
 =?iso-8859-1?Q?/kKn0mBF1+4IDN97i7T7tvAJoX0Cioi/3cWr7qjYkbnc0XujE0O0en4OJF?=
 =?iso-8859-1?Q?GTBlh28Z3ZLqwoWrut7/ISDlSpXvVGfDwu0WoULxKWhmOnzOhzlagpD0YF?=
 =?iso-8859-1?Q?K305YD1mbWLhO4CN/TKeY/i7Dgt/hLqOUkZkaX+z/Cn0ceUfFnNlunaX8x?=
 =?iso-8859-1?Q?hAkDhDiAki8eXU52eVq6nSgWQmGLOTaZxhD8BQmhkXFJg9zDZPRGtpBP0P?=
 =?iso-8859-1?Q?nV1WHNze/bDD426Qci2Scy7MzENyKsSQBthwS7VJi0v8i38f1HQDLASdko?=
 =?iso-8859-1?Q?zWt6qW4X2C+/LUP19Cv9EH9lrDLWadLi92P9t+n+hptvx0LJg/4++s4HDZ?=
 =?iso-8859-1?Q?AYf6qfztRA=3D=3D?=
X-Exchange-RoutingPolicyChecked: DMHZdDn3QF9ci6z8m8Oa4nZXH1eTbr1kbFNWo9wbHwdwcsIZyAmKiYqyNJVY1UsSAJzIGMvgv1MUWT7zuubgO/U9sDHyRZ9PTalZvGqphASsrB9N0wU6iZsPU/k696vwwN3XOvlgzoAwyDt7Ww/Jp1RKplnhNk8gvgZQHU+HOTnfZ2kXsvOgkTqAhZt291kwYufwqSEAWx6v6UqGxShDj2W8lZi+x6k+Aax4VDWLJYL3IbfsS6fQT9vsffuk8yFIELWuzs3CByJwHhu0Ntwi22EliU5VNWahB1Yym+JCABYuSTQlpJNtMXYs4qc+foUZFCUTCB6yyRyB/+Zk2Xw6YQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6d6068-8c87-4947-bfc1-08dea56083db
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 19:58:28.3688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDFYqW60xx5U9P0cyKw8V0k2NQ7p70l07mrJLV2Qx28N8zFPa0NtYVIoMBWHOY8KXw4m0ky2OXKIoP43wXEn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com
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

On Tue, Apr 28, 2026 at 02:09:31PM +0300, Jani Nikula wrote:
> On Tue, 28 Apr 2026, Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com> wrote:
> > UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> > uncommitted changes in the source tree or new commits). So when checking
> > if a patch introduces changes to the resulting binary each usage of
> > UTS_RELEASE is source of annoyance.
> >
> > Instead of using UTS_RELEASE directly use init_utsname()->release which
> > evaluates to the same string but with that a change of UTS_RELEASE
> > doesn't affect xe_devcoredump.o.
> >
> > Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Cc: José Roberto de Souza <jose.souza@intel.com>

Jose, ack on this?!

I'm afraid this could break the current Mesa parser, so better checking first...

> 
> > ---
> > Hello,
> >
> > (implicit) v1 of this patch is available at 
> > https://lore.kernel.org/20260427160902.1126027-2-u.kleine-koenig%40baylibre.com.
> >
> > The only changes since then is that instead of dropping the kernel line,
> > init_utsname()->release is used, which is nearly what Jani Nikula
> > suggested.
> 
> Almost the same, but better. ;)
> 
> I wonder if most UTS_RELEASE uses in the kernel should be changed the
> same way?
> 
> 
> BR,
> Jani.
> 
> 
> >
> > Best regards
> > Uwe
> >
> >  drivers/gpu/drm/xe/xe_devcoredump.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> > index 558a1a9841a0..07c7c89240d8 100644
> > --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> > +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> > @@ -8,7 +8,7 @@
> >  
> >  #include <linux/ascii85.h>
> >  #include <linux/devcoredump.h>
> > -#include <generated/utsrelease.h>
> > +#include <linux/utsname.h>
> >  
> >  #include <drm/drm_managed.h>
> >  
> > @@ -101,7 +101,7 @@ static ssize_t __xe_devcoredump_read(char *buffer, ssize_t count,
> >  
> >  	drm_puts(&p, "**** Xe Device Coredump ****\n");
> >  	drm_printf(&p, "Reason: %s\n", ss->reason);
> > -	drm_puts(&p, "kernel: " UTS_RELEASE "\n");
> > +	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
> >  	drm_puts(&p, "module: " KBUILD_MODNAME "\n");
> >  
> >  	ts = ktime_to_timespec64(ss->snapshot_time);
> >
> > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> 
> -- 
> Jani Nikula, Intel
