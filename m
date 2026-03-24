Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F250E9A774
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE7310E5EE;
	Tue, 24 Mar 2026 11:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L5QyNHZB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8633F10E5E2;
 Tue, 24 Mar 2026 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774351661; x=1805887661;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IZvizGmJR6TYGKcrKWBWPZB1kDmg4y20tlmypaPWHQk=;
 b=L5QyNHZBAdLbtMx4vIWa3YC9anpe6GhjNuc0ZMmmIKrEnUUk18Lfu/sf
 dkwGryPdHl2N41rS7d+3qHWTS67ABqQ+2EI+vRX0slZpztlWHW+OqUgfw
 kYd5l5TSXn+Ct4sbFdqCTNvbYHrOt61Xi9/dt/ot6pEUhBEVSKe7CTt6M
 vXQZRiNPbFNh1dCdsGH7QdnoiRv4b7ZBbiicxN8VHMGiUZZlJ53W61kOU
 cKe6LdBC+0/EcwMudMPA0QoKCHKcOQxpRLYlYUeVSy8B0guUPhXc0H+iU
 WBnYR5T3Q/W5hmsLQ/e0dBwZ6r2a7wLC2jQ84oel+D9h7N1QUcQNYb3Ml Q==;
X-CSE-ConnectionGUID: TuJuJmA8TlyPdXIjJx8jpw==
X-CSE-MsgGUID: SUESyLrNRgSOZeqj+eIPoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86734380"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="86734380"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:27:40 -0700
X-CSE-ConnectionGUID: ZBEu5WG/QPeAc1k33rgKWw==
X-CSE-MsgGUID: 9W9ZwOfoQfSyRLHF6ttHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="224567379"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:27:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 04:27:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 04:27:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 04:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXYANZyYDtG3ZctBrxSYXRT/r/1hcKLCzV1z0M6HviPgk90945qg3vwmU15vaUBBq7Nb7BtAvFaiuENLB+QuqJyd3ttgc8QQi5lHd7t9UN8MumOB5rpfzEM7QSWEVOo0f2E+lMIT1ZyevORzf9tidGUQLCls3y+d9zu2WSzKiqefxWYkJdcMi4Cr56qToU0IEIcVc2sHbax5s6ITV1gy0qVv4YNf4uyR6XFY+wmYafssnsFaZm6YA431YY9Z13M0EMM5yNOM+xD2lBFcnfSdRpOF+IndXE5DXEvlTXOwUginN4oOu377KCo77TwyviCMaoxam6YYjOXeDd7AY3K92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZvizGmJR6TYGKcrKWBWPZB1kDmg4y20tlmypaPWHQk=;
 b=eupYmi7aH7+zi5qcYQRmNMOcY3pOOdfMDmu4idlkkTWWqSSagow5o7HPVnQNDKqZd8b79bYInyOtapfCIi1fnzA1kstwIvY8PZTNkNkgTmMCIs6ZYgNLah0fX69MqxiOtc4YCKG9nEp312Taj+aVlb9GUdhXbSADKasZ2RpAKtJrfavR7vvJ9i9cNpw9oemfI1/pG/9pczFSPu2lnfVkG7ltkv07EsTCfZePkDPqOwK4pWHTyufwhh6k7fmsTeT/EeMMRjwu9RXio2jjeToOwPw9ghvAvUZI0nUlf80sHKWANK76ogkZyeW2Rd4I/1FwJ3hVhDawEt4M0E14Y84xHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 11:27:35 +0000
Received: from CH0PR11MB5564.namprd11.prod.outlook.com
 ([fe80::bdb2:f221:b705:aaeb]) by CH0PR11MB5564.namprd11.prod.outlook.com
 ([fe80::bdb2:f221:b705:aaeb%2]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 11:27:35 +0000
From: "Girotra, Himanshu" <himanshu.girotra@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Brost, Matthew" <matthew.brost@intel.com>,
 =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH] drm/syncobj: Fix xa_alloc allocation flags
Thread-Topic: [PATCH] drm/syncobj: Fix xa_alloc allocation flags
Thread-Index: AQHcu37j/ags5ALHV0eIaoueTNaaMrW9i0Cg
Date: Tue, 24 Mar 2026 11:27:35 +0000
Message-ID: <CH0PR11MB5564E08C3A491EF4841217D49848A@CH0PR11MB5564.namprd11.prod.outlook.com>
References: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5564:EE_|MN2PR11MB4600:EE_
x-ms-office365-filtering-correlation-id: b1db31e9-39c1-4421-a45b-08de89985913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: RFcSRETwtJPxT7g7OBEPcwKYZYuSInPimspced5zCxdMBWTdbVwFodqgdufndZy8ZV7+SjDvz2HsygU1ibPH0B50T+Jnpn1RsEo7v/qicuGSqoMe7LbUqAaNn4DXb08xT2yu/msDlxohhSlJcgTKeBsuwiRGuK1Xi0hMzlt+J9CSC4rd+TS/q87j+q4+4YRa7VIH41Q4OrwO3cLVb1AvMNgHDRnNtfj1CxvJo/XrJRtqjqjSDDa5TcivfiswrUF5bw/A4l3hjPBwHzhJUfNgnzFxdnYxWJRk5GULKMCDzQStPIYLQKiWbYs7lxTVjBqD0A4ZRwNieMWWbOheOv2Gll2AKtbbsge1kltkmeW8TZ/CHvie68NRXMqN6GQklfA9iDn+sjaq5MrzxrDAu8bXh9inFE0m64DcSG29jYJ7W1pxRUwdaKcnIJyLdpDzwMO3B09n1ClM5waaw8+Ti3Y7c62seUpEte6eq4zeT5IFlrsyMrv5B2YFU2tcC062YvReHDz6A63yQ38GDjtOTISACXvTnIFI7R8o9CDm44yLUgFvehHIxNLz/Pmxn7lf1ccMBaW2mtNoCoPIZ2G/DQeNwBG+5v/UjA+Kh5MkMXMdKtx7xTkfPNhM+3J87HKbQt3PaDwcLm6E0K1ASLYyp1UevuJMLPLg8LWTGNkw4rl/DajzLddZfAyNMlZxP03+iHH+fvpJ3vkoXKpYc6XT47l/moNQT7bDOl4Oo5BiCdxKTaxe3CH6prNm5aeP7w5E26K1ZQdpZ9KbfitsjEj5uAgw+XLqSEnRU0XJM/vvwSbq7ns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR11MB5564.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJiUUlrS1pvK2ZqTG5lcEgvSTlZV1ppdjhaNGZxcFhOK3ZUWGJoLzIzYUxV?=
 =?utf-8?B?WmdlSHF0RFNhMlhkNEJXdFZiUTNQK0RrOWFaQ0ErL2FXbndNdDBSWVFyWlMv?=
 =?utf-8?B?b2NzVytHWWlxL3VLV0JrU2RJbkdiVjZHRWxLbGRBRUt4ZldhUmlocFlnNVBS?=
 =?utf-8?B?WnNxLzJib0pMYU9jRHNaS2ZiUURuZHQ4RTkveHA0NUFybi9yaEdFeS8vVys5?=
 =?utf-8?B?VnhFbnpqTyswT0tjKzlDclpNMzFWelFETUlWbmlSbnlIZzhlc2VrcnZrWGxE?=
 =?utf-8?B?T0ZxSlJrTzJabVJkSVU1c1pNVWpqcXFiNlNtblRyU1hVb016Q0VRQnJYZmFG?=
 =?utf-8?B?c1UxbUVXaDZZZTFGby9DYnRNc0YwaFVxM25vNUNKN2M4WktxZWxSMjVjcEdU?=
 =?utf-8?B?OGJzZUdoakpvcjR2RGxmaDRvMm5RODA5WlJsZTVNOFFDQnNiRDQxNzhBK3lT?=
 =?utf-8?B?VThqRkxFTGcweXN4Z0FaU1FKUUpNTHFRMlFRc2g1MEtQM0JHYUVEbUtrNmJ3?=
 =?utf-8?B?aXlrZ3JCUExlMDhDUnl3OUszMGwzWko5TXNzT3d5VWp0RlVKVEU4QlJEcWlZ?=
 =?utf-8?B?dWR0L2I2SE4wVnAxeDIySjdOeXRkcW9xeFZuVFh6dFNpUmF1alN1UjV6QWtN?=
 =?utf-8?B?bTJlOVNNblJUUFd5R1F0YTA3MEVMQk9VSC9VTXhvVHA2K2xFekVObkp2OXZp?=
 =?utf-8?B?Vk1wSlVhN1hhMDFpeEVLRmFtWm5kVEM3cVVQSlFNSGVvMitQN1dpRTY3T21K?=
 =?utf-8?B?RHQ2eDR0NjNrdldETHN1Mmw3SUZPeHlPRVY4dGNjOXp3eFhoWnZ3T0RLNWpU?=
 =?utf-8?B?bDlCRWNzbHl3Q1pOL1hkV1dJclJpNzRNTzZXRmIydFZ1c2dreVEwcEVsQlQy?=
 =?utf-8?B?eTRJS20wMkF6VHRwcG13NkcwblExNml0NzF2R2t1VmdnenFwemdWNys5TERU?=
 =?utf-8?B?bjFUK0N3dXNleXpRMWp1MlR3SWxPRlpLc08zRlhXM2R5Z3hCVUxUWDRNL1dm?=
 =?utf-8?B?Y0xLcHpzUzdoTjNZekJ2V3F2ZFFYUUtxWVBPWU1vVWZHY1VwUWFsUU4rclNk?=
 =?utf-8?B?ZTY0WmNTdXdMS2FhNVhZdUpINHMycmM5QmpYVFYyMmdqRnVlTU9qRlZyVVhZ?=
 =?utf-8?B?dGFTaThURHBRaVM3WDZSQUpuYW5GTVBJcW01QXExNGF1a1M3dkY3c1ZtbFd2?=
 =?utf-8?B?UFdQQzB1YWpTUytLRlNFVUNleGFkZy90R1BKT2FPemkzM2x2L3J2UVR4aC9v?=
 =?utf-8?B?MkN3SVlFdkM1clZTWkhtS2xVUkw5aWl5RSsxU3pCc2thdWIzU0hNYVdxem5u?=
 =?utf-8?B?bnFBMEg3ZGhla0E2emUyNmY1SEtJNmdQYVBNSlByWkNmbzhpbGdDcHRIZGh4?=
 =?utf-8?B?Z2xJMG42aERSVFV2dWczbjNlNVpLVFlzZ3JjRjI3K0FUN05tbTRGTjJITU9m?=
 =?utf-8?B?bkJZVDFOcUc0MEV5eUZkWnQrTkFGTlpPQ05MNG14c0crcFY0SS9tN0lZSXZm?=
 =?utf-8?B?Z2FxMXBXRFdOZ1lqNFExNTJTSnVFVWx6OFpPTVUxNFBuODdNMGxMSGExWUpZ?=
 =?utf-8?B?cHZheVVSRHM5UUZ6Y21kd0Yxc01XWGM4bUt5ODArMmV1aWRFWE1mRHVzUGhk?=
 =?utf-8?B?TFNUTER1bWlJS3UzK3Q0bTlnOC9wZGU0QjlQNHNJdHhVeHZjZ0c4OHliY0RM?=
 =?utf-8?B?dWV3QVFYR3NkcHZrLzBDYjlyd0ZDTHJwcjlYNkxkTlJXNTJneEd6ZU9rZTlZ?=
 =?utf-8?B?TXA5MXVuOXY4aXVyN0RGMEFrVnVJYlhsSm1Vd0RIZ0dZcEN5c05nYW5pMGRP?=
 =?utf-8?B?dHcwTTYzYjJSUXQ2c2JQNmJuMFVxQ2h4bnNIRjBua01raW50Qk5rVjJDZjBv?=
 =?utf-8?B?Ukp6YmdiT2o5MUZVcGlpM2U1OTdaTG8yZUZUa05WUCsxVnN5OGZuZksvTjl6?=
 =?utf-8?B?RUlINVg0Wnc5ZlZLcHo5aUtCY0ZBQjRieVZaUXdDYWJkWjdWOS9ySmFqUWNY?=
 =?utf-8?B?RDB0SnoyUHFHV2UxMDB5N004a21FZVRPTEJuQ0pMczYvbFRQSlZac0l3Z2Zu?=
 =?utf-8?B?UUY3MHVCQmtnaG9CcTMzN1FISzY3TzdYb2ZZV3Rsbi9OSnhZQ2ZteTVKMkhR?=
 =?utf-8?B?MitQaXZnZVc5akVDS3ppYUZNTVFzdFBrWEtZNkVBeVBUR0hreUQvb1J4dmM3?=
 =?utf-8?B?ZmFyQWNXQW1QUmpVUi9hQ3QyU05yOERXSHJid2ducWRxSFI2SDF3MHQ5SW9I?=
 =?utf-8?B?TzlDMWVoRGNpdjJrdnhIdnhuV0picFRsM2VVcXo5cVZoMXRxV293TFcyV1d1?=
 =?utf-8?B?aGFtbkczZVhUd05kYkVaT0w1bmdPV3FpT21XUStjTElIT2V0RXlsZmptWTRL?=
 =?utf-8?Q?Yhmusfn00FwUmAMx/LOL6owCQ/dzybmwBmtKcGUgqJm4G?=
x-ms-exchange-antispam-messagedata-1: E7gs3UG7cRwOjw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YlJcL5IJBzobAooC0MRseyAMswTU/+QtJqyJbpPVoWMguJ6lSIjBogxJ9H4w9C4vrf91ssERh1ETww8BasV3hLxFCSy2HUeUkhGIyoRAHWqfaPexEjJYAJ8F6Bsi09k5FL2WOU/PO1B6ert1mkSKQEZdvOpxs1NlEtsbnbRm8IHrSciv2PtxHsSs5HzhIdWB11U/EfYBOKYVuDghYNkMBDd4VH9b11qLxWwE93BfiaKyDWILkgKH1jlNc2W/0/VnBhr0Oz0f7v2ePOstWH/bTVsl9yAkSzEigBDd4/LT89NB06ou9ls/Qxxu201BUmZigV7eYpcm/SP1R9jIuD6yog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5564.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db31e9-39c1-4421-a45b-08de89985913
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:27:35.5466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OhRth92u6UmUBqWGgAj4HvUGmnMqpbC2nxCl/uoJNGf4B4V7jYLex4Z5a55dHx2I+FJFqXCoM66Bl+VfkjHIqa0XEaB0RH3aPFRrAExnKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHZydGtvIFVyc3VsaW4g
PHR2cnRrby51cnN1bGluQGlnYWxpYS5jb20+DQo+IFNlbnQ6IDI0IE1hcmNoIDIwMjYgMTY6NDAN
Cj4gVG86IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogVHZydGtvIFVyc3VsaW4gPHR2cnRrby51cnN1bGluQGlnYWxp
YS5jb20+OyBHaXJvdHJhLCBIaW1hbnNodQ0KPiA8aGltYW5zaHUuZ2lyb3RyYUBpbnRlbC5jb20+
OyBCcm9zdCwgTWF0dGhldyA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+Ow0KPiBUaG9tYXMgSGVs
bHN0csO2bSA8dGhvbWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gZHJtL3N5bmNvYmo6IEZpeCB4YV9hbGxvYyBhbGxvY2F0aW9uIGZsYWdzDQo+IA0KPiBU
aGUgeGFycmF5IGNvbnZlcnNpb24gYmxpbmRseSBhbmQgd3JvbmdseSByZXBsYWNlZCBpZHJfYWxs
b2Mgd2l0aCB4YV9hbGxvYyBhbmQNCj4ga2VwdCB0aGUgR0ZQX05PV0FJVC4gSXQgc2hvdWxkIGhh
dmUgYmVlbiBHRlBfS0VSTkVMIHRvIGFjY291bnQgZm9yDQo+IGlkcl9wcmVsb2FkIGl0IHJlbW92
ZWQuIEZpeCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFR2cnRrbyBVcnN1bGluIDx0dnJ0a28u
dXJzdWxpbkBpZ2FsaWEuY29tPg0KPiBGaXhlczogZmVjMmMzYzAxZjFjICgiZHJtL3N5bmNvYmo6
IENvbnZlcnQgc3luY29iaiBpZHIgdG8geGFycmF5IikNCj4gUmVwb3J0ZWQtYnk6IEhpbWFuc2h1
IEdpcm90cmEgPGhpbWFuc2h1Lmdpcm90cmFAaW50ZWwuY29tPg0KPiBDYzogTWF0dGhldyBCcm9z
dCA8bWF0dGhldy5icm9zdEBpbnRlbC5jb20+DQo+IENjOiBUaG9tYXMgSGVsbHN0csO2bSA8dGhv
bWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBIaW1hbnNodSBH
aXJvdHJhIDxoaW1hbnNodS5naXJvdHJhQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vZHJtX3N5bmNvYmouYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX3N5bmNvYmouYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fc3luY29iai5jDQo+IGluZGV4
IDI1MDczNGRlZTkyOC4uOGQ5ZmQxOTE3YzZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX3N5bmNvYmouYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmouYw0K
PiBAQCAtNjAyLDcgKzYwMiw3IEBAIGludCBkcm1fc3luY29ial9nZXRfaGFuZGxlKHN0cnVjdCBk
cm1fZmlsZQ0KPiAqZmlsZV9wcml2YXRlLA0KPiAgCWRybV9zeW5jb2JqX2dldChzeW5jb2JqKTsN
Cj4gDQo+ICAJcmV0ID0geGFfYWxsb2MoJmZpbGVfcHJpdmF0ZS0+c3luY29ial94YSwgaGFuZGxl
LCBzeW5jb2JqLA0KPiB4YV9saW1pdF8zMmIsDQo+IC0JCSAgICAgICBHRlBfTk9XQUlUKTsNCj4g
KwkJICAgICAgIEdGUF9LRVJORUwpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWRybV9zeW5jb2JqX3B1
dChzeW5jb2JqKTsNCj4gDQo+IEBAIC03MTYsNyArNzE2LDcgQEAgc3RhdGljIGludCBkcm1fc3lu
Y29ial9mZF90b19oYW5kbGUoc3RydWN0IGRybV9maWxlDQo+ICpmaWxlX3ByaXZhdGUsDQo+ICAJ
ZHJtX3N5bmNvYmpfZ2V0KHN5bmNvYmopOw0KPiANCj4gIAlyZXQgPSB4YV9hbGxvYygmZmlsZV9w
cml2YXRlLT5zeW5jb2JqX3hhLCBoYW5kbGUsIHN5bmNvYmosDQo+IHhhX2xpbWl0XzMyYiwNCj4g
LQkJICAgICAgIEdGUF9OT1dBSVQpOw0KPiArCQkgICAgICAgR0ZQX0tFUk5FTCk7DQo+ICAJaWYg
KHJldCkNCj4gIAkJZHJtX3N5bmNvYmpfcHV0KHN5bmNvYmopOw0KPiANCj4gLS0NCj4gMi41Mi4w
DQoNCg==
