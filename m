Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B1BCD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD2510EF27;
	Thu,  7 May 2026 01:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a/bx5rZd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18FB010EF27;
 Thu,  7 May 2026 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778116678; x=1809652678;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WS0TbNzDsBO7sBQBuhPNH4Yyy8OziDdZR1yjL/lh5M0=;
 b=a/bx5rZdUPV+wdhSUJvv71ROvddxbxUauZDR9DPPJfuND72VjTHawYpw
 iURKaodAY/Fzdl727NSHXCvdne9KqRmsqSMmHzD/aaFpfpvcQT+SUv0O7
 R0fvNlvTw2Kk+RXiK0TSZWk+oPVBwolcXdlyUdxUmQCQzyfGMHEjg3y+T
 YhdKzSbCUr8hIx36x9lvbHgvK4EnEqwf5OowcpK5fOP0ayfYBousbiTda
 7h+cpqR08LxROeAFYuxcNeyVw4ttKH1633R511UF9cv8q/eCUDgPh0/xD
 uToE01pZLtgl1+cAv169sGgRmdknxgeanH2+BwjtJ/ub4WA8CWdHkpQC2 w==;
X-CSE-ConnectionGUID: Zsz1fCCoT+++5BMv422/sw==
X-CSE-MsgGUID: 4sVkJcpOQSOVPu3ydkGniA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89757556"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="89757556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 18:17:57 -0700
X-CSE-ConnectionGUID: nIkQw/HXQVSN11DZJDXafw==
X-CSE-MsgGUID: 452nLTo3T3qg27+lpiDfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="266690323"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 18:17:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 18:17:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 18:17:56 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 18:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3qZ5UsX4k5adOlmaaGPKFsMEEeDpX0Yn10s7hgeZove1QkcyRf+qzgKPEIJ+6N9x5BiRaAR2O67fAhz5WoQPHL43zMeXb/KKvjTycp/n2zEHn0lMCb4cuvIyB6MSxOwHZ++Oi19x1cPCF+KEuAsHjQ90pDiKsKiQRxpEudvYiX5LbXpJ56Yt9GeV/t+dOxD1h1lO6noepOOu/hM22I6lIH0++IVtHW0TDd4JPO5HrA6HNMJdGJo8B+v+pknn2U0eIdyQ1ow2Umlz+uuo4p5nLqS04DNqEXzpua2E2iiZWqiq2dljhRU/Dl0P6Znlq/XO6mdJm9PcFQK6KddnSBwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2mpuzB5/gop/+ZapgNWu//gLFehh9HQ0J67zPcKxPg=;
 b=U6F2aq/YJM3R2J4dnya+xtwqe47anMS5WfwJIWgBrMYdPBLEyTGPB03dHPAVlYRP3WDBHK4XSWZyFyNJf3IKfPy6AVVQ5qWOuk167lzfh/iBaX6WBRbC1JfZG5tJeOrJwI3Qz9lVs7VcL/zvMLlruZhPy8p3X6PHkhtg0jOI3HglyNmNNrZIf+fXMXVJ2sH4fUx5/UPnlUA2xfIoGpFkGlVzCnZ1gkZx/EGma5mIcXt2BhvPN3WAo6YZANsi2xJ3giQH67TMvyhn4dyhMfPH/KV8PleJMumHZefW6ilSjPhhiQyfz93A9vGF5dgfv7DAb4rLnXMVLXgD6rk7JM3hIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14)
 by DS4PPFBA72E12AE.namprd11.prod.outlook.com (2603:10b6:f:fc02::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 01:17:52 +0000
Received: from DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082]) by DM4PR11MB5456.namprd11.prod.outlook.com
 ([fe80::62e5:4a7c:f965:9082%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 01:17:52 +0000
From: "Lin, Shuicheng" <shuicheng.lin@intel.com>
To: "Brost, Matthew" <matthew.brost@intel.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Auld,
 Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v3] drm/gpusvm: Drop redundant @flags.* kernel-doc on
 struct drm_gpusvm_pages
Thread-Topic: [PATCH v3] drm/gpusvm: Drop redundant @flags.* kernel-doc on
 struct drm_gpusvm_pages
Thread-Index: AQHc2ZRaHoNcfsLn6E+vgwdGkaSunbX5w5sAgAgGjHA=
Date: Thu, 7 May 2026 01:17:51 +0000
Message-ID: <DM4PR11MB54566E418AC5AEEE8DCF1E4FEA3C2@DM4PR11MB5456.namprd11.prod.outlook.com>
References: <20260501175956.4054088-1-shuicheng.lin@intel.com>
 <afUrpqc4vd0zFekW@gsse-cloud1.jf.intel.com>
In-Reply-To: <afUrpqc4vd0zFekW@gsse-cloud1.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5456:EE_|DS4PPFBA72E12AE:EE_
x-ms-office365-filtering-correlation-id: a3e7a8c4-3728-49d6-b6a4-08deabd675bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HcPx6A9KiGMqw6b7qrV4J4hJQBqJr6cHG2TjT9wsZR+W6YyWgxlujtSGojecDUgax7PmJoiePLdKHGnwNSXnP6veaqRwDnxvuC/bK0jFSkI00jq0H3EBRmLY/EqQq+99hdMAZL4qjfQAcLtxZDra8NPAotnAYVMPTTDGikLrskM8DqBvw9Phh3wzUTgjDjs20RXXZK6HM20osJKuyJNVx89FAM7WTuu5RSSNBD5iSJuH8ETlADQNAWp+TXRRCdEzB0er/M93FTBcrzudPCo4dHvDFv8dQu+gMij45BO+Vx+nIeBggBIy+SLgH5wMyTZeG/msYu2eNdv4bGo1+SImhDQV7BZuX1NUzRbEJUxCLWb0ojcbk/671WnwGpRwjpKg4sMevbapgA0PshJ/oea8vGDGOT2UKX9ZdEL0xyeSV3YYkpazb2H0j0PQtmh43KrGtS9EhNgHgI3b8tvVYRwmmb2OxBlxbAt8wTjFJ8F34rZIwhqrN/qLnCR34e7CE/YaLdAoN1svXFrriIhq8DCBiiR6hGlvdYXrGiQOECU2EnZ3V33IPYTg0qAUlOBW7eQgqf7wLAlAu6XKTDSIf1ZhGaIcBGCiW/Mx0pVdisoTM1s2xV2sYsiObzg6Gi9APP2OGgGnqMwYyHZVU1nj5k3tMEEh82hnyGqZ005cnpalnE3Illn0bBfGXMDRqbIsAGZaKVVhMzJTtyrFxD6kaExZEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5456.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kdkhbEwbnbKablYG4hXRDfP0YY0zm0Cuw0LbKAcKdws91BE84bn8tNtLZa07?=
 =?us-ascii?Q?4jDpB6wOBVUs8RxUcOjA/a29KUAfvyPzZ91TpXLBWl3j/Y//U8GdKRzZnZZK?=
 =?us-ascii?Q?zr1dNeK9HIkFoC6oBt4f79sQ2qayXWIRj4AirurqnVaPfh/oJD9iFMVkXe5w?=
 =?us-ascii?Q?YKCDdt3gx3YNMe7I5lYklJhpC8qZbNR09u3FKF+tFWm+mndZTgB31UL6WrAr?=
 =?us-ascii?Q?xUhOeO8eRwfgBYGu73Clc1kKAZsMj/5jA5I9CJIluDgUuGkyc6xzMN/pVwCL?=
 =?us-ascii?Q?njcpbIFSNcrNC5mxQOo6JQFUtuiEnGLX3amu2Cpur1ouNC/Dt1ySe/Kixkws?=
 =?us-ascii?Q?fgWZxcj5GYyfdxBYuhtKnvqqUpz3CsIzKmXranTieasDIv8lP/gN7yCWUwM1?=
 =?us-ascii?Q?Qb6qfXXuoPbd5tO0I2L5pzJxVjPe0xvtXTu7vazSI+qwUMo3J8gEY/Fx+Umr?=
 =?us-ascii?Q?2yr1gVpX7Ac18QLdjr34C5mkUbUUyaUjSb93DePk074njQTMO6R0qQolcroe?=
 =?us-ascii?Q?KYOW7Mq1HpSM4RE4n/YMMmo0Rbznf8bEpJNdkoFFwHgZtJl/eF1KPPKv+yNb?=
 =?us-ascii?Q?VkDTiqeoRiMj5OdNV9CLxpmgLa7tXtUX0T3L8eK6TVRveiIkkN5+92kzOLwl?=
 =?us-ascii?Q?Wl8I/Dh/UgyM61nOH01PyI3Z1iY0w7n6mr/3Pa65s2wPavX3xDKjZp3W8yaO?=
 =?us-ascii?Q?BdoOC4HEuhGDJlhTwT/HjAMWgYENYKN97sCrlOhewXQBarjKi+1D3dQb81ze?=
 =?us-ascii?Q?QVT51eOjuepyTMvns7L+uRLO7TicuR8pJylFeVU1XRfVkTmWMoc1vy1DELK+?=
 =?us-ascii?Q?GaZrHxylfq/yiiyfr4NmfmvPm3Ra7mky/bVhm1u09MCoj2djsZgEVBG05Hc8?=
 =?us-ascii?Q?/c/OqSmmpAs70RM1EOuEooymFHqVtjGqYhYRR2ymi3q3xFQP4o4aAHPJKjkX?=
 =?us-ascii?Q?IsGAl1KJuayi0N5Z+wDx0Vz8ubFZfMLtP/RUS+BWh8sJzilpT0w2SYL1X4Ae?=
 =?us-ascii?Q?aM/biLE6aKfj5BZ+lcct6gGxdxZ14/UCveSNvC1B9xOr1dELlS0NyPMNKTPN?=
 =?us-ascii?Q?YLt2c2e5woNQXaEiLcYiw7ocvYGdZZ3tjcgfvzZg23HyamGmu4oBHJT6ohTd?=
 =?us-ascii?Q?MWDdV7fvD7Xbm4GPUKFO9PBWR0LT7Mi2S7msnm3Bnm9qKghxQJi6b5zDw9Ll?=
 =?us-ascii?Q?ECNZ50i7Y6V8wFEdm61+0NxX0fz9PU739vmtr653rnRwoTxtONkze2kJpyvx?=
 =?us-ascii?Q?0h2epEotZnJzfE0I/i1LvjcuBx0lN7h9KqgQLYD1QmEw07ZPabZkQ4UDIAZq?=
 =?us-ascii?Q?hqngWDtiE/KtPPWVAulOR7RXQGosw6SyOjwzo4QQSHdKWUNlIS4hJ8PXA3oC?=
 =?us-ascii?Q?77N8Ib7dJqJdSv5j3G69OdgrILLIwGHFAXZfFy8YpZMtwzQU4F0jt5kAjvNX?=
 =?us-ascii?Q?Xww4haiS9DCWEZjIg57VYh0WL5ggY3mrOohStdwEW+NN7ODRw+5+Q9edDwwW?=
 =?us-ascii?Q?L+8uxYsUjn/haqIvXnoKEg9hBJryaRkf8AGkTB7R54ktYKZ2fSWPVmArWzZW?=
 =?us-ascii?Q?oCW5DJ7wWAEyAeIymrpv/En9AMZCRgKyIF14uQC00Hx2KG8Wr0ZWzCZbnLMF?=
 =?us-ascii?Q?D7rtRwyACIQBe9Vsnvucq6I4Ww0xwIDF5hNRR16aVYOxTdqvBZVP0B/zobTJ?=
 =?us-ascii?Q?RtoEwTNM+XR5KrYo4hnkz1hi+aElTfBK5DH/uEDL1qoylu7mdw4578fSOXfB?=
 =?us-ascii?Q?2390RULU25d+yCoIywOG+N9vlnUzZgcDJ4Re0CzPuymCPjAAQT7U7/xlF67H?=
x-ms-exchange-antispam-messagedata-1: D6CVBScUcOvGCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k/v7FK91hpH/U/xQir9FKlIxrWIJQcPN41xE1PDQL6MbIh4x9EN8fulo22VkiUKk+PNMLfApZx6fMKdyHguLaGZNTvsxKaTpYN6AhyUg01BCxWt1SCMgqmuE3yXMqR1XJQ5wtPQJO/1j6kNFa5Crh/MPmPcH+b2sORxnGAKlaWoJJK+E7hfGTaR6tSHR4iZJeoMGkqyiDHzg3Ylrx5Bqauti4CAdHuLGuR/wJyKvQOU+hqcQRFQ6FrDsp8tVGEX5nVI0SEwoWpMlh18vrsHXuaDaXLOEklNYZU32QdZjfqOieH7XwYOFSA7kUgmGufM3MQysGXCKeJQHQygwqm9jiw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5456.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e7a8c4-3728-49d6-b6a4-08deabd675bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 01:17:51.9688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTks1p1/qS5UzD9gL9S5WPELbkr8ImvGSpEWuJO7aVI1pUDWsTak+GASzvShoh7arZJ8aDvBJPv4PhpDgtwUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBA72E12AE
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

Thanks Matt for the review.

Hi drm misc maintainers,
Could you please help me merge it?
Thanks in advance for your support.

Shuicheng

On Fri, May 1, 2026 3:40 PM Matthew Brost wrote:
> On Fri, May 01, 2026 at 05:59:56PM +0000, Shuicheng Lin wrote:
> > The kernel-doc block above struct drm_gpusvm_pages duplicates the
> > descriptions of the bit-flags that live in struct
> > drm_gpusvm_pages_flags using dotted notation (@flags.migrate_devmem,
> @flags.unmapped, ...).
> > That dotted notation is intended for nested anonymous structs/unions
> > that the parser flattens into the parent's parameter list.  Here,
> > however, flags is of a named external type, so the parser does not
> > flatten its members and the dotted entries do not match any member of
> > drm_gpusvm_pages.  They also duplicate the canonical descriptions
> > already present in the kernel-doc of struct drm_gpusvm_pages_flags itse=
lf.
> >
> > Drop the five @flags.* lines and replace them with a single @flags
> > entry that cross-references the type via kernel-doc's "&struct ..." syn=
tax.
> > This eliminates the redundancy and removes warnings emitted by the new
> > parameterdescs check in scripts/kernel-doc:
> >
> >   Excess struct member 'flags.migrate_devmem' description in
> >    'drm_gpusvm_pages'
> >   Excess struct member 'flags.unmapped' description in 'drm_gpusvm_page=
s'
> >   Excess struct member 'flags.partial_unmap' description in
> >    'drm_gpusvm_pages'
> >   Excess struct member 'flags.has_devmem_pages' description in
> >    'drm_gpusvm_pages'
> >   Excess struct member 'flags.has_dma_mapping' description in
> >    'drm_gpusvm_pages'
> >
> > No functional change.
> >
> > Assisted-by: Claude:claude-opus-4.6
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
>=20
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>=20
> > ---
> > v2: change base to drm-misc.
> > v3: correct the assisted-by tag.
> >
> > The failure is reported by the new kernel-doc check in:
> > https://patchwork.freedesktop.org/series/164948/
> > ---
> >  include/drm/drm_gpusvm.h | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h index
> > cd94bb2ee6ee..8a4d7134a9a7 100644
> > --- a/include/drm/drm_gpusvm.h
> > +++ b/include/drm/drm_gpusvm.h
> > @@ -140,12 +140,7 @@ struct drm_gpusvm_pages_flags {
> >   * @state: DMA IOVA state for mapping.
> >   * @state_offset: DMA IOVA offset for mapping.
> >   * @notifier_seq: Notifier sequence number of the range's pages
> > - * @flags: Flags for range
> > - * @flags.migrate_devmem: Flag indicating whether the range can be
> > migrated to device memory
> > - * @flags.unmapped: Flag indicating if the range has been unmapped
> > - * @flags.partial_unmap: Flag indicating if the range has been
> > partially unmapped
> > - * @flags.has_devmem_pages: Flag indicating if the range has devmem
> > pages
> > - * @flags.has_dma_mapping: Flag indicating if the range has a DMA
> > mapping
> > + * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
> >   */
> >  struct drm_gpusvm_pages {
> >  	struct drm_pagemap_addr *dma_addr;
> > --
> > 2.43.0
> >
